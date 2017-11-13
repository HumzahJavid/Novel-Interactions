/*
  Tracked Objects
 TUIO 1.1 Demo for Processing
 
 Modified by Bob Fields Sept 2016.
 
 Note: we need to used the 
 synchronized(objects) {
     ...
 }
 construct to avoid problems when two threads use the objects mapping. 
 Without synchronisation, if the map is modified (e.g. by adding or removing an item)
 while another thread is using it, a ConcurrentModificationException is thrown.
 
 */

// import the TUIO library
import TUIO.*;
import java.util.Map;
import java.util.Collections;
import java.util.List;

// declare a TuioProcessing client
TuioProcessing tuioClient;

// these are some helper variables which are used
// to create scalable graphical feedback

PFont font;
Map<Integer, TrackedObject> objects = 
  Collections.synchronizedMap(new HashMap<Integer, TrackedObject>());
  HashMap<Integer> zero = new HashMap<Integer>();


boolean includes(int element, int[] list) {
  
}
void setup()
{
  //size(displayWidth,displayHeight);
  size(600, 400);

  rectMode(CENTER);
  noFill();

  font = createFont("Arial", 18);
  textFont(font);

  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);
}

// within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
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

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene

void addTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  synchronized(objects) {
    TrackedObject o = new TrackedObject(""+id);
    o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
    o.size=(int)random(50, 100);
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
// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
 println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  //if (callback) redraw();
}