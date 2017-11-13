import TUIO.*;
import java.util.Map;
import java.util.Collections;
import java.util.List;

int Binary[] = {1, 0};
String Hex[] = {"1", "2"};
String Operator[] = {"+", "-"};

TuioProcessing tuioClient;

PFont font;

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


 boolean contains(int element, int[] arr) {
 
 boolean goat = false;
 
  for(int i = 0; i < arr.length; i++){
    if (element == arr[i]) {
      goat = true;
    }    
  }
  return goat;
 }

void addTuioObject(TuioObject tobj) {
  
  int id = tobj.getSymbolID();
  
  
  
  synchronized(objects) {
    o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
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