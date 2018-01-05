import TUIO.*;
import java.util.Map;
import java.util.Collections;
import java.util.List;
import java.util.Comparator;

TuioProcessing tuioClient;

PFont font;
//stores all the detected bits
ArrayList<Bit> bitList = new ArrayList<Bit>();

ArrayList<Bit> binaryOne = new ArrayList<Bit>();
ArrayList<Bit> binaryTwo = new ArrayList<Bit>();

ArrayList<Bit> binaryOneTemp = new ArrayList<Bit>();
ArrayList<Bit> binaryTwoTemp = new ArrayList<Bit>();

Map <Integer, DetectedObject> objects = 
  Collections.synchronizedMap(new HashMap<Integer, DetectedObject>()); 
LogicGate and1;
LogicGate or1;
LogicGate not1;
ArrayList<LogicGate> gateList = new ArrayList<LogicGate>();

int bitIds[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
//and, or, not, .... xor nand nor nxor 
int gateIds[] = {30, 31, 32, 33};

void setup() {
  size(1000, 650);
  textSize(30);

  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  tuioClient  = new TuioProcessing(this);
}

void addBinary() {
  if (bitList.size() > 3) {
    binaryOneTemp.clear();
    Collections.sort(bitList, compX);
    for (int i = 0; i < 4; i++) {
      binaryOneTemp.add(bitList.get(i));
    }
    //System.out.println("Binary One " + binaryOne);
    drawRectOne();
  }
  if (bitList.size() > 7){
    binaryTwoTemp.clear();
    for (int i = 0, j = 4; i < 4; i++, j++) {
      binaryTwoTemp.add(bitList.get(j));
    }
    drawRectTwo();
  }
}

void drawRectOne() {
  ArrayList<Bit> binaryOneClone = new ArrayList<Bit>();
  binaryOneClone.clear();
  binaryOneClone.addAll(binaryOneTemp);
  Collections.sort(binaryOneClone, compY);
  
  int binOneFirst = bitList.get(0).getX();
  int binOneLast = bitList.get(3).getX();
  int binOneYFirst = binaryOneClone.get(0).getY();
  int binOneYLast = binaryOneClone.get(3).getY();
  if (binOneLast - binOneFirst < 350  && binOneYLast - binOneYFirst < 75) {
    binaryOne.clear();
    binaryOne.addAll(binaryOneTemp);
    rectMode(CENTER);
    pushMatrix();
    rectMode(CORNER);
    noFill();
    rect(binOneFirst - 50, binOneYLast + 50, binOneLast - binOneFirst + 100, binOneYFirst - binOneYLast - 100, 10);
    popMatrix();
    rectMode(CENTER);
  }
}

void drawRectTwo() {
  ArrayList<Bit> binaryTwoClone = new ArrayList<Bit>();
  binaryTwoClone.clear();
  binaryTwoClone.addAll(binaryTwoTemp);
  Collections.sort(binaryTwoClone, compY);
  
  int binTwoFirst = bitList.get(4).getX();
  int binTwoLast = bitList.get(7).getX();
  int binTwoYFirst = binaryTwoClone.get(0).getY();
  int binTwoYLast = binaryTwoClone.get(3).getY();
  if (binTwoLast - binTwoFirst < 350 && binTwoYLast - binTwoYFirst < 75) {
    binaryTwo.clear();
    binaryTwo.addAll(binaryTwoTemp);
    rectMode(CENTER);
    pushMatrix();
    rectMode(CORNER);
    noFill();
    rect(binTwoFirst - 50, binTwoYLast + 50, binTwoLast - binTwoFirst + 100, binTwoYFirst - binTwoYLast - 100, 10);
    popMatrix();
    rectMode(CENTER);
  }
}

void draw() {
  background(255);
  synchronized(objects) {
    //objects now contains DetectedObjects (Bit, Binary and LogicGate and potentially MathOperator Objects)
    for (DetectedObject to : objects.values()) {
      to.draw();
    }
  }
  addBinary();
}

public static boolean contains(int element, int[] arr) {
  //returns true if the element "element" is is in the array "arr"  
  boolean contained = false;
  for (int i = 0; i < arr.length; i++) {
    if (element == arr[i]) {
      contained = true;
    }
  }
  return contained;
}

public static boolean checkInputsWithinRange(LogicGate gate, ArrayList<Bit> bitList) {
  //checks the distance between the gate and all detected bits 
  //if 2 bits are within xrange of the gate then return true
  float xGate = gate.getX();
  float yGate = gate.getY();
  int bitsDetected = 0;
  //if the gate has inputs assigned(inputs are full)
  boolean gateInputsAssigned = gate.inUse();
  //if the bit is assigned to a gate
  boolean assignedToGate;

  for (Bit bit : bitList) {
    float xBit = bit.getX();
    float yBit = bit.getY();
    assignedToGate = (gate.input1 == bit || gate.input2 == bit);
    if (withinXRange(xGate, gate.size, xBit) && withinYRange(yGate, gate.size, yBit) && !assignedToGate && !gateInputsAssigned) {
      bitsDetected += 1;
    }
  }
  if (gate instanceof NotGate) {
    if (bitsDetected == 1) {
      return true;
    } else {
      return false;
    }
  } else {
    if (bitsDetected == 2) {
      return true;
    } else {
      return false;
    }
  }
}

public static ArrayList<Bit> getBitsInRange(LogicGate gate, ArrayList<Bit> bitList) {
  //returns all the bits in proximity of the gate
  float xGate = gate.getX();
  float yGate = gate.getY();
  ArrayList<Bit> closeBits = new ArrayList<Bit>();
  for (Bit bit : bitList) {
    float xBit = bit.getX();
    float yBit = bit.getY();
    boolean assignedToGate;
    assignedToGate = (gate.input1 == bit || gate.input2 == bit);
    if (withinXRange(xGate, gate.size, xBit) && withinYRange(yGate, gate.size, yBit) && !assignedToGate) {
      closeBits.add(bit);
    }
  }
  return closeBits;
}

public static void propogateOutputs(ArrayList<LogicGate> gateList, ArrayList<Bit> bitListAndOutputs, int num) {
  //Uses a combined list made up of the bitList and oldOutputs 
  //to produce a new set of outputs which are combined with the list and used in the next recursive call
  //recursive calls end when no new outputs are generated
  ArrayList<Bit> newOutputBits = new ArrayList<Bit>();
  for (LogicGate gate : gateList) {
    if (checkInputsWithinRange(gate, bitListAndOutputs)) {
      ArrayList<Bit> inputBits = new ArrayList<Bit>();
      inputBits = getBitsInRange(gate, bitListAndOutputs);

      if (gate instanceof NotGate) {
        //System.out.println("Not gate has an input " + inputBits.get(0));
        newOutputBits.add(gate.output(inputBits.get(0)));
      } else {
        //System.out.println("not a not gate has an inputS " + inputBits.get(0) + " ..." + inputBits.get(1));
        newOutputBits.add(gate.output(inputBits.get(0), inputBits.get(1)));
      }
    }
  }

  if (newOutputBits.size() > 0) {
    bitListAndOutputs.addAll(newOutputBits);
    //System.out.println("new bitlist size " + bitListAndOutputs.size());
    propogateOutputs(gateList, bitListAndOutputs, num+1);
  } else {
    //System.out.println("ending propogateOutputs at call # " + num);
    bitListAndOutputs.clear();
  }
}

public static boolean withinXRange(float xGate, int gateWidth, float xBit) {
  //check if object is within 100 of the left/right of the gate
  float xMin = xGate - 100;
  float xMax = xGate;// + gateWidth + 100;
  if ((xBit >= xMin)&&(xBit <= xMax)) {
    return true;
  } else {
    return false;
  }
}

public static boolean withinYRange(float yGate, int gateHeight, float yBit) {
  //check if object is within 100 of the top of the gate or bottom of the gate
  float yMin = yGate - 100;
  float yMax = yGate + gateHeight + 100;
  if ((yBit >= yMin)&&(yBit <= yMax)) {
    return true;
  } else {
    return false;
  }
}

void addTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  if (contains(id, bitIds)) { 
    Bit o = new Bit();
    synchronized(objects) {
      //no number objects added if array is full
      switch(id) {

      case 0:  
      case 1: 
      case 2: 
      case 3: 
      case 4: 
      case 5: 
      case 6: 
      case 7:
        o.setText("0");
        o.setValue(0);
        o.setId(id);
        break;

      case 8: 
      case 9: 
      case 10: 
      case 11: 
      case 12: 
      case 13: 
      case 14: 
      case 15:
        o.setText("1");
        o.setValue(1);
        o.setId(id);
        break;
      }
      o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
    }
    o.size = 50;
    objects.put(id, o);
    if (o instanceof Bit) {
      bitList.add(o);
    }
  } else if (contains(id, gateIds)) {
    //if the id is that of a logicGate, create the corresponding logic gate (o) 
    //add o to the object hashmap and the gateList arraylist 
    LogicGate o;
    switch (id) {
    case 30:
      o = new AndGate();
      break;
    case 31:
      o = new OrGate();
      break;
    case 32:
      o = new NotGate();
      break;
    case 33:
      o = new XOrGate();
      break;
    default:
      o = new AndGate();
      break;
    }
    o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
    o.size = 50;
    o.id = id;
    objects.put(id, o);
    if (o instanceof LogicGate) {
      gateList.add(o);
    }
  };
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  int id = tobj.getSymbolID();
  ArrayList<Bit> outputBits = new ArrayList<Bit>();
  ArrayList<Bit> bitListAndOutputs = new ArrayList<Bit>();

  synchronized(objects) {
    if (objects.containsKey(id)) {
      DetectedObject o = objects.get(id);
      o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
      o.setAngle(tobj.getAngle());
    }

    for (LogicGate gate : gateList) {
      //if the gate has inputs in range (and does not have inputs already assigned to it)
      if (checkInputsWithinRange(gate, bitList)) {
        ArrayList<Bit> inputBits = new ArrayList<Bit>();
        inputBits = getBitsInRange(gate, bitList);
        //calculates output for the gate and add it to a list of outputBits
        if (gate instanceof NotGate) {
          outputBits.add(gate.output(inputBits.get(0)));
        } else {
          outputBits.add(gate.output(inputBits.get(0), inputBits.get(1)));
        }
      } else if (gate.inUse() && bitList.contains(gate.input1)) {
        if (gate.inputsStillInRange()) {
          outputBits.add(gate.output);
        } else {
          //the inputs are not in range set output to blank
          gate.blankOutput();
        }
      } else {
        //gate does not have inputs assigned and has no potential inputs in range, set output to blank (-1)
        gate.blankOutput();
      }
    }  
    //with all newly created output bits need to check if any are in range of gates to be considered inputs 
    bitListAndOutputs.addAll(bitList);
    bitListAndOutputs.addAll(outputBits);
    if (outputBits.size() != 0) {
      propogateOutputs(gateList, bitListAndOutputs, 1);
    }
  }
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  Bit bitToRemove = new Bit();
  LogicGate gateToRemove = new AndGate();

  synchronized(objects) {
    if (objects.containsKey(id)) {
      objects.remove(id);
    }
    for (Bit bit : bitList) {
      if (bit.id == id) {
        bitToRemove = bit;
      }
    }
    if (bitToRemove.id != -1) {
      bitList.remove(bitToRemove);
    }
    bitToRemove = null;

    for (LogicGate gate : gateList) {
      if (gate.id == id) {
        gateToRemove = gate;
      }
    }
    gateToRemove.destroyOutput();
    gateList.remove(gateToRemove);
    gateToRemove = null;
  }
}

Comparator<Bit> compX = new Comparator<Bit>() {
  public int compare(Bit o1, Bit o2) {
    if (o1.getX()<o2.getX()) { 
      return -1;
    } else if (o1.getX()>o2.getX()) { 
      return 1;
    } else { 
      return 0;
    }
  }
};

Comparator<Bit> compY = new Comparator<Bit>() {
  public int compare(Bit o1, Bit o2) {
    if (o1.getY()<o2.getY()) { 
      return -1;
    } else if (o1.getY()>o2.getY()) { 
      return 1;
    } else { 
      return 0;
    }
  }
};

//for debug purposes
public static void printArr(int[][] arr) {
  for (int i = 0; i < arr.length; i++) {
    for (int j = 0; j < arr[i].length; j++) {
      System.out.print(arr[i][j] + " ");
    }
    System.out.println("");
  }
}

public static void printArr(int[] arr) {
  for (int i = 0; i < arr.length; i++) {
    System.out.print(arr[i] + " ");
  }
  System.out.println("");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  //println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  //if (callback) redraw();
}