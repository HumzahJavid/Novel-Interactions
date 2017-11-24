abstract class LogicGate extends DetectedObject {
  int size=60;
  int input1;
  int input2;
  int output;

  LogicGate() {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
  }
  
  LogicGate(int x, int y) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    locX = x;
    locY = y;
  }

  void draw() {
    noFill();
    stroke(rectCol);

    pushMatrix();
    translate(locX, locY);
    rect(0, 0, size, size, rad, rad, rad, rad);
    popMatrix();

    fill(textCol);
    text(text, locX, locY);
  }
  
  abstract void blankOutput();
  //for all other gates
  abstract void output(Bit bit1, Bit bit2);
  String toString() {
    return "\n rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " size: " + size
      + " TrackedObject type: LogicGate";
  }
}