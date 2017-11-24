import TUIO.*;
import java.util.Map;
import java.util.Collections;
import java.util.List;
import java.util.Comparator;

TuioProcessing tuioClient;

PFont font;
//stores all the detected bits
ArrayList<Bit> bitList = new ArrayList<Bit>();
Map <Integer, TrackedObject> objects = 
  Collections.synchronizedMap(new HashMap<Integer, TrackedObject>()); 
LogicGate and1;
LogicGate or1;
LogicGate not1;
ArrayList<LogicGate> gateList = new ArrayList<LogicGate>();

void setup()
{
  size(1000, 650);
  textSize(30);

  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  tuioClient  = new TuioProcessing(this);

  //setup the test AndGate on the screen 
  and1 = new AndGate(700, 300);
  gateList.add(and1);
}

void draw()
{
  background(255);
  synchronized(objects) {
    for (TrackedObject to : objects.values()) {
      to.draw();
    }
    for (LogicGate lg : gateList) {
      lg.draw();
    }
  }
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

public static boolean checkInputsWithinRange(LogicGate and1, ArrayList<Bit> bitList) {
  //checks the distance between the gate and all detected bits 
  //if 2 bits are within xrange of the gate then return true
  float xAnd = and1.getX();
  float yAnd  = and1.getY();
  int bitsDetected = 0;

  for (Bit bit : bitList) {
    float xBit = bit.getX();
    float yBit = bit.getY();
    if (((xAnd - xBit) < 100) && (withinYRange(yAnd, and1.size, yBit))){
      bitsDetected += 1;
    }
  }
  
  if (bitsDetected == 2) {
    return true;
  } else {
    return false;
  }
  
}

public static ArrayList<Bit> getBitsInRange(LogicGate and1, ArrayList<Bit> bitList) {
  //returns all the 
  float xAnd = and1.getX();
  float yAnd  = and1.getY();
  ArrayList<Bit> closeBits = new ArrayList<Bit>();
  for (Bit bit : bitList) {
    float xBit = bit.getX();
    float yBit = bit.getY();
    
    if ((xAnd - xBit) < 100) {
      closeBits.add(bit);
    }
  }

  return closeBits;
}

public static boolean withinYRange(float yGate, int gateHeight, float yBit){
  //check if object is within 100 of the top of the gate or bottom of the gate
  float yMin = yGate - 100;
  float yMax = yGate + gateHeight + 100;
  if ((yBit >= yMin)&&(yBit <= yMax)){
    return true;
  } else {
    return false;
  }
}

void addTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
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
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  int id = tobj.getSymbolID();
  synchronized(objects) {
    if (objects.containsKey(id)) {

      TrackedObject o = objects.get(id);
      o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
      o.setAngle(tobj.getAngle());
    }
  }
  if (checkInputsWithinRange(and1, bitList)) {
    ArrayList<Bit> inputBits = new ArrayList<Bit>();
    inputBits = getBitsInRange(and1, bitList);
    System.out.println("input bits " + inputBits.get(0).value + " " + inputBits.get(1).value);
    //calculates output for the gate
    and1.output(inputBits.get(0), inputBits.get(1));
  } else {
    //complete output (1 bit for Not, 2 bits for all other gates) no longer being detected so set output to blank
    and1.blankOutput();
  };
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  TrackedObject bitToRemove = new Bit();
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
      //this and adding need work(maybe use proximity based)
      bitList.remove(bitToRemove);
    }
  }
}

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