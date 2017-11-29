class NotGate extends LogicGate {
  String text = "NOT";
  NotGate() {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    blankOutput();
  }

  NotGate(int x, int y) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    locX = x;
    locY = y;
    blankOutput();
  }

  void draw() {
    //System.out.println(this);
    noFill();
    stroke(rectCol);

    pushMatrix();
    translate(locX, locY);
    rect(0, 0, size, size, rad, rad, rad, rad);
    popMatrix();

    fill(textCol);
    text(text, locX, locY);
    //drawOutputText();
    updateOutput();
    drawLineToInputs();
    drawLineToOutput();
  }

  public void blankOutput() {
    input1 = new Bit("", -1);
    input2 = new Bit("", -1);
    updateOutput();
  }

  Bit calculateOutput(Bit bit1) {
    // System.out.println("calculating output " + bit1.value);
    if (bit1.value != -1) {
      Bit outputBit = new Bit();
      if (bit1.value == 1) {
        outputBit.setValue(0);
      } else {
        outputBit.setValue(1);
      }
      return outputBit;
    } else {
      return bit1; //-1
    }
  }
  
  void destroyOutput(){
    output = null;
  }
  
  void drawLineToInputs() {
    stroke(rectCol);
    if (input1.value != -1) {
      float input1X = input1.getX();
      float input1Y = input1.getY();
      line(input1X, input1Y, this.getX(), this.getY());
    }
  }

  void drawLineToOutput() {
    stroke(output.rectCol);
    if (input1.value != -1) {
      float outputX = output.getX();
      float outputY = output.getY();
      line(outputX, outputY, this.getX(), this.getY());
    }
  }

  void drawOutputText() {
    //possibly add a box around output
    updateOutput();
    float answerX= locX+ 1.2* size; //move it to the right of the gate 
    float answerY= locY;
    pushMatrix();
    translate(answerX, answerY);
    //text(""+output, 0, -0.15*textAscent()); 
    text(""+output, 0, 0);
    popMatrix();
  }
  
  public boolean inputsStillInRange(){
    return (inputInRange(input1));
  }

  private boolean inputInRange(Bit input) {
    return (inputWithinXRange(input) && inputWithinYRange(input));
  }

  private boolean inputWithinXRange(Bit input) {
    float xMin = this.getX() - 100;
    float xMax = this.getX();
    float xBit = input.getX();
    if ((xBit >= xMin)&&(xBit <= xMax)) {
      return true;
    } else {
      return false;
    }
  }

  private boolean inputWithinYRange(Bit input) {
    float yMin = this.getY() - 100;
    float yMax = this.getY() + this.size + 100;
    float yBit = input.getY();
    if ((yBit >= yMin)&&(yBit <= yMax)) {
      return true;
    } else {
      return false;
    }
  }

  boolean inUse() {
    return (input1.value != -1);
  }

  Bit output(Bit bit1) {
    updateInputs(bit1);
    return updateOutput();
  }

  void updateInputs(Bit bit1) {
    this.input1 = bit1;
  }

  Bit updateOutput() {
    output = calculateOutput(input1);    
    output.rectCol = color(0, 255, 255);
    output.setPos(this.getX() + 100, this.getY());
    output.setAngle(this.getAngle());
    output.text= ""+output.value;

    output.draw();
    return output;
  }

  String toString() {
    return "\n input1: " + input1 + " input2: " + input2 + " output: " + output + "Logic gate type: Not";
  }
}