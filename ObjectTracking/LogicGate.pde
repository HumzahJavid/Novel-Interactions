abstract class LogicGate extends DetectedObject {
  int size=60;
  Bit input1;
  Bit input2;
  Bit output;
  int id;

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

  abstract void draw();
   
  void blankOutput() {
    input1 = new Bit("", -1);
    input2 = new Bit("", -1);
    //will call the sub class implementation
    updateOutput();
  }
  
  abstract void drawLineToInputs();
  abstract void drawLineToOutput();
  
  void destroyOutput(){
    output = null;
  }
  
  abstract void drawOutputText();
  abstract boolean inputsStillInRange();

  protected boolean inputInRange(Bit input) {
    return (inputWithinXRange(input) && inputWithinYRange(input));
  }

  protected boolean inputWithinXRange(Bit input) {
    float xMin = this.getX() - 100;
    float xMax = this.getX();
    float xBit = input.getX();
    if ((xBit >= xMin)&&(xBit <= xMax)) {
      return true;
    } else {
      return false;
    }
  }

  protected boolean inputWithinYRange(Bit input) {
    float yMin = this.getY() - 100;
    float yMax = this.getY() + this.size + 100;
    float yBit = input.getY();
    if ((yBit >= yMin)&&(yBit <= yMax)) {
      return true;
    } else {
      return false;
    }
  }
    
  boolean inUse(){
    return (input1.value != -1);
  }
  
  //not abstract because a Not gate shouldn't (implement the function which) gives an output based on Two input bits
  Bit output(Bit bit1) {
    return bit1;
  };
  
  Bit output(Bit bit1, Bit bit2) {
    return bit1;
  };

  abstract Bit updateOutput();
}