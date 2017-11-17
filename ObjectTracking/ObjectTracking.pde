import TUIO.*;
import java.util.Map;
import java.util.Collections;
import java.util.List;

TuioProcessing tuioClient;

PFont font;
public static int[] BinaryInput = new int[8];
public static int temp = 0;
int [][] PositionTrack = new int[8][3];


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

    PositionTrack[temp][0] = id;
    PositionTrack[temp][1] = tobj.getScreenX(width);
    PositionTrack[temp][2] = tobj.getScreenY(height);
    temp++;
    System.out.println(" ");
    
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 3; j++){
        System.out.print(PositionTrack[i][j] + " ");
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
  }
}

void SortPosition() {
  if (PositionTrack[7][1] == 0) {
    ;
  } else {
    int BiggestX = 0;
    int IdBiggest = 0;
    int FillBinary = 7;
    int temp = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        for (int k = 0; k < 8; k++) {
          if (PositionTrack[k][1] > BiggestX) {
            BiggestX = PositionTrack[k][1];
            IdBiggest = PositionTrack[k][0];
            temp = k;
          }
        }
      }
      BinaryInput[FillBinary] = IdBiggest;
      FillBinary--;
      PositionTrack[temp][1] = 0;
      BiggestX = 0;
      IdBiggest = 0;
    }
    for (int i = 0; i < 8; i++) {
      System.out.print(BinaryInput[i]);
    }
  }
}