class OrGate extends LogicGate {
  String text = "OR";
  OrGate() {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    blankOutput();
  }

  OrGate(int x, int y) {
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

  Bit calculateOutput(Bit bit1, Bit bit2) {
    //return (bit1.value | bit2.value);
    Bit outputBit = new Bit();
    outputBit.setValue(bit1.value | bit2.value);
    return outputBit;
  }
  
  void destroyOutput(){
    output = null;
  }

  void drawLineToInputs() {
    stroke(rectCol);
    //if both inputs are assigned a value
    if (input1.value != -1 && input2.value != -1) {
      float input1X = input1.getX();
      float input1Y = input1.getY();
      float input2X = input2.getX();
      float input2Y = input2.getY();
      line(input1X, input1Y, this.getX(), this.getY());
      line(input2X, input2Y, this.getX(), this.getY());
    }
  }

  void drawLineToOutput() {
    stroke(output.rectCol);
    if (input1.value != -1 && input2.value != -1) {
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
  
  boolean inUse(){
    return (input1.value != -1);
  }

  Bit output(Bit bit1, Bit bit2) {
    updateInputs(bit1, bit2);
    return updateOutput();
  }

  void updateInputs(Bit bit1, Bit bit2) {
    this.input1 = bit1;
    this.input2 = bit2;
  }

  Bit updateOutput() {
    output = calculateOutput(input1, input2);

    output.rectCol = color(0, 255, 255);
    output.setPos(this.getX() + 100, this.getY());
    output.setAngle(this.getAngle());
    output.text = ""+output.value;
    output.draw();
    return output;
  }

  String toString() {
    return "\n input1: " + input1 + " input2: " + input2 + " output: " + output + "Logic gate type: Or";
  }
}