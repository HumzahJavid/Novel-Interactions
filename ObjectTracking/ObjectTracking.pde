import TUIO.*;
import java.util.Map;
import java.util.Collections;
import java.util.List;
import java.util.Comparator;

TuioProcessing tuioClient;

PFont font;
//the binary input (obeject ids)
public static int[] binaryInput = new int[8];
//keeps track of the first available index(empty space) of positionTrack
public static int temp = 0;
int [][] positionTrack = new int[8][3];
//stores all the detected bits
ArrayList<TrackedObject> bitList = new ArrayList<TrackedObject>();
Binary binary1 = new Binary();
// - (width*2) + (height/2)
Binary binary2 = new Binary(1000-60, 30);
Map <Integer, TrackedObject> objects = 
  Collections.synchronizedMap(new HashMap<Integer, TrackedObject>());

void setup()
{
  positionTrack = setupEmptyPositionTrack(positionTrack);
  size(1000, 650);
  textSize(30);

  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  tuioClient  = new TuioProcessing(this);
}

void draw()
{
  binary1.sort(comp);
  background(255);
  //List<TrackedObject> tos = objects.values();
  synchronized(objects) {
    for (TrackedObject to : objects.values()) {
      to.draw();
    }
  }

  binary1.draw();
  binary2.draw();
}

Comparator<TrackedObject> comp = new Comparator<TrackedObject>() {
  // Comparator object to compare two TuioObjects on the basis of their x position
  // Returns -1 if o1 left of o2; 0 if they have same x pos; 1 if o1 right of o2

  // allows us to sort objects left-to-right.
  public int compare(TrackedObject o1, TrackedObject o2) {
    if (o1.getX()<o2.getX()) { 
      return -1;
    } else if (o1.getX()>o2.getX()) { 
      return 1;
    } else { 
      return 0;
    }
  }
};

void addTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  TrackedObject o = new Bit();
  synchronized(objects) {
    //no number objects added if array is full
    if (temp < positionTrack.length) {
      switch(id) {

      case 0:  
      case 1: 
      case 2: 
      case 3: 
      case 4: 
      case 5: 
      case 6: 
      case 7:
        //o = new Bit("0", 0, id);
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
        //o = new Bit("1", 1, id);
        o.setText("1");
        o.setValue(1);
        o.setId(id);
        break;
      }
      //System.out.println(o);
      o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));

      positionTrack[temp][0] = id;
      positionTrack[temp][1] = tobj.getScreenX(width);
      positionTrack[temp][2] = tobj.getScreenY(height);
      temp++;
    }
    System.out.println(" ");

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 3; j++) {
        //System.out.print(positionTrack[i][j] + " ");
      }
      System.out.println(" ");
    }

    SortPosition();

    o.size = 50;
    objects.put(id, o);

    if (o instanceof Bit) {
      bitList.add(o);
      //if there are less than 5 bit object detected
      if (bitList.size() < 5) {
        binary1.add(o);
        //else there are more than 4 bit objects detected
      } else {
        //if the second binary number is not full
        if (binary1.size() >= 4 && binary2.size() < 4) {
          System.out.println("binary1 is full size:" + binary1.size());

          System.out.println("binary2 is at size:" + binary2.size());
          System.out.println("adding object to b2");
          binary2.add(o);
          //else do not add any bits to either binary object
        } else {
          System.out.println("binary1 is AT size:" + binary1.size());

          System.out.println("binary2 is at size:" + binary2.size());
          System.out.println("ISSUE");
        }
      } //end if else bitlist < 5
    }// end if o is Bit
  }//end sync
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

  //when obj moved check if binary values are still close to each other 
  //else split them and construct new binary value
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  TrackedObject bitToRemove = new Bit();
  synchronized(objects) {
    if (objects.containsKey(id)) {
      objects.remove(id);
    }
    for (TrackedObject bit : bitList) {
      //System.out.println(bit.id);
      if (bit.id == id) {
        bitToRemove = bit;
      }
    }

    if (bitToRemove.id != -1) {
      //this and adding need work(maybe use proximity based)
      bitList.remove(bitToRemove);
      if (binary1.contains(bitToRemove)) {
        binary1.remove(bitToRemove);
      } else {
        binary2.remove(bitToRemove);
      }
      //binary1.remove(bitToRemove);
    }

    //System.out.println("bit list sizeafter removing " + bitList);

    positionTrack = removeObjectFromPositionTrack(id, positionTrack);
  }
}

int[][] removeObjectFromPositionTrack(int id, int[][] positionTrack) {
  /*removes the object with the id "id", updates the index "temp" 
   and returns the updated positionTrack array*/

  int length = positionTrack.length;
  for (int i = 0; i < length; i++) {
    //if the object to be removed is found
    if (positionTrack[i][0] == id) {
      //shift the remaining bit objects to the left by 1
      //effectively removing the object  
      for (int j = (i + 1); j < length; j++) {
        positionTrack[j - 1] = positionTrack[j];
      }
      //decrement the first available empty space (index);
      temp = temp - 1;
    }
  }
  //clear the last object
  for (int i = 0; i < 3; i++) {
    positionTrack[7][i] = -1;
  }
  return positionTrack;
}

void SortPosition() {
  if (positionTrack[7][1] == -1) {
    ;
  } else {
    int biggestX = 0;
    int idBiggest = 0;
    int fillBinary = 7;
    int temp = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        for (int k = 0; k < 8; k++) {
          if (positionTrack[k][1] > biggestX) {
            biggestX = positionTrack[k][1];
            idBiggest = positionTrack[k][0];
            temp = k;
          }
        }
      }
      binaryInput[fillBinary] = idBiggest;
      fillBinary--;
      positionTrack[temp][1] = 0;
      biggestX = 0;
      idBiggest = 0;
    }
    for (int i = 0; i < 8; i++) {
      //System.out.print(binaryInput[i] + " ");
    }
  }
}

public int[] convertToBinary(int[][] positionTrack ) {
  //this function loops through positionTrack and checks the fiducial marker values, 
  //stores a 0 or 1 in the actualBinaryValues array depending on which list the marker belongs in
  int[] bitZeroList = {0, 1, 2, 3, 4, 5, 6, 7};
  int[] bitOneList = {8, 9, 10, 11, 12, 13, 14, 15};
  int[] actualBinaryValues = new int[positionTrack.length];

  for (int i = 0; i < positionTrack.length; i++) {
    //the number is a zero
    if (contains(positionTrack[i][0], bitZeroList)) {
      actualBinaryValues[i] = 0;
      //the number is a one
    } else if (contains(positionTrack[i][0], bitOneList)) {
      actualBinaryValues[i] = 1;
    }
  }
  return actualBinaryValues;
}

public int[] convertToBinary(int[] arr) {
  //this function loops through array "arr" and checks the fiducial marker values, 
  //stores a 0 or 1 in the actualBinaryValues array depending on which binary values the marker represents
  int[] bitZeroList = {0, 1, 2, 3, 4, 5, 6, 7};
  int[] bitOneList = {8, 9, 10, 11, 12, 13, 14, 15};
  int[] actualBinaryValues = new int[arr.length];

  for (int i = 0; i < arr.length; i++) {
    //the number is a zero
    if (contains(arr[i], bitZeroList)) {
      actualBinaryValues[i] = 0;
      //the number is a one
    } else if (contains(arr[i], bitOneList)) {
      actualBinaryValues[i] = 1;
    }
  }
  return actualBinaryValues;
}

public int[] reverseArr(int[] arr) {
  //used to reverse the binary number
  for (int i = 0; i < arr.length / 2; i++) {
    int temp = arr[i];
    arr[i] = arr[arr.length - 1 - i];
    arr[arr.length - 1 - i] = temp;
  }
  return arr;
}

public boolean contains(int element, int[] arr) {
  //returns true if the element "element" is is in the array "arr"  
  boolean contained = false;
  for (int i = 0; i < arr.length; i++) {
    if (element == arr[i]) {
      contained = true;
    }
  }
  return contained;
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

public static int[][] setupEmptyPositionTrack(int[][] positionTrack) {
  for (int[] numberObject : positionTrack) {
    numberObject[0] = -1;
    numberObject[1] = -1;
    numberObject[2] = -1;
  }
  return positionTrack;
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