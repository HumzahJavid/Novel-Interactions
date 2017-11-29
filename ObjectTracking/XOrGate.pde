class XOrGate extends LogicGate {
  String text = "XOR";
  XOrGate() {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    blankOutput();
  }

  XOrGate(int x, int y) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    locX = x;
    locY = y;
    blankOutput();
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
    updateOutput();
    drawLineToInputs();
    drawLineToOutput();
  }

  Bit calculateOutput(Bit bit1, Bit bit2) {
    Bit outputBit = new Bit();
    int outputValue;
    if (bit1.value != bit2.value){
      outputValue = 1;
    } else if(bit1.value == -1) {
      outputValue = -1;
    } else {
      outputValue = 0;
    }
    outputBit.setValue(outputValue);
    return outputBit;
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

  public boolean inputsStillInRange(){
    return (super.inputInRange(input1) && super.inputInRange(input2));
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
    return "\n input1: " + input1 + " input2: " + input2 + " output: " + output + "Logic gate type: XOr";
  }
}