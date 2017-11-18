import TUIO.*;
import java.util.Map;
import java.util.Collections;
import java.util.List;

TuioProcessing tuioClient;

PFont font;
public static int[] binaryInput = new int[8];
//keeps track of the first available index(empty space) of positionTrack
public static int temp = 0;
int [][] positionTrack = new int[8][3];


Map <Integer, TrackedObject> objects = 
  Collections.synchronizedMap(new HashMap<Integer, TrackedObject>());

void setup()
{
  size(1000, 650);
  textSize(30);

  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  tuioClient  = new TuioProcessing(this);
}

void draw()
{
  background(255);
  //List<TrackedObject> tos = objects.values();
  synchronized(objects) {
    for (TrackedObject to : objects.values()) {
      to.draw();
    }
  }
}

void addTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  TrackedObject o = new TrackedObject(" ");
  synchronized(objects) {
    switch(id) {

    case 0:  
    case 1: 
    case 2: 
    case 3: 
    case 4: 
    case 5: 
    case 6: 
    case 7:
      o = new TrackedObject("0");
      break;

    case 8: 
    case 9: 
    case 10: 
    case 11: 
    case 12: 
    case 13: 
    case 14: 
    case 15:
      o = new TrackedObject("1");
      break;
    }
    o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));

    positionTrack[temp][0] = id;
    positionTrack[temp][1] = tobj.getScreenX(width);
    positionTrack[temp][2] = tobj.getScreenY(height);
    temp++;
    System.out.println(" ");

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 3; j++) {
        System.out.print(positionTrack[i][j] + " ");
      }
      System.out.println(" ");
    }

    SortPosition();

    o.size = 50;
    objects.put(id, o);
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
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  synchronized(objects) {
    if (objects.containsKey(id)) {
      objects.remove(id);
    }
    positionTrack = removeObjectFromPositionTrack(id, positionTrack);
  }
}

int[][] removeObjectFromPositionTrack(int id, int[][] positionTrack){
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
  return positionTrack;
}

void SortPosition() {
  if (positionTrack[7][1] == 0) {
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
      System.out.print(binaryInput[i]);
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