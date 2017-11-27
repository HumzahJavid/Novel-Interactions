abstract class LogicGate extends DetectedObject {
  int size=60;
  Bit input1;
  Bit input2;
  Bit output;

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
  //not abstract because a Not gate shouldn't (implement the function which) gives an output based on Two input bits
  Bit output(Bit bit1) {
    return bit1;
  };
  Bit output(Bit bit1, Bit bit2) {
    return bit1;
  };

  String toString() {
    return "\n rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " size: " + size
      + " Bit type: LogicGate";
  }
}