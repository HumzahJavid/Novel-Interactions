import TUIO.*;
import java.util.Map;
import java.util.Collections;
import java.util.List;

TuioProcessing tuioClient;

PFont font;

public static int[] Binary = {1,1,1,1,1};

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
    
    switch(id){
      
      case 0:  case 1: case 2: case 3: case 4: case 5: case 6: case 7:
      o = new TrackedObject("0");
      break;
      
      case 8: case 9: case 10: case 11: case 12: case 13: case 14: case 15:
      o = new TrackedObject("1");
      break;
      
    }
    
    o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
    
    System.out.println(" ");
    System.out.println(id);
    System.out.println(tobj.getScreenX(width));
    System.out.println(tobj.getScreenY(height));
    System.out.println(" ");
    
    o.size = 50;
    objects.put(id, o);
  }
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  int id = tobj.getSymbolID();
  synchronized(objects) {
    if (objects.containsKey(id)) {
      
      System.out.println(" ");
      System.out.println(id);
      System.out.println(tobj.getScreenX(width));
      System.out.println(tobj.getScreenY(height));
      System.out.println(" ");
    
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
    
    System.out.println(" ");
    System.out.println(id);
    System.out.println(tobj.getScreenX(width));
    System.out.println(tobj.getScreenY(height));
    System.out.println(" ");
    
    if (objects.containsKey(id)) {
      objects.remove(id);
    }
  }
}