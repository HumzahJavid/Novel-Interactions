class AndGate extends LogicGate {
  String text = "AND";
  AndGate() {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    blankOutput();
  }
  
  AndGate(int x, int y) {
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
    drawOutputText();
  }
  
  public void blankOutput() {
    input1 = -1;
    input2 = -1;
    updateOutput();
  }

  int calculateOutput(int bit1, int bit2){
    return (bit1 & bit2);
  }
  
  void drawOutputText(){
    //possibly add a box around output
    updateOutput();
    float answerX= locX+ 1.2* size; //move it to the right of the gate 
    float answerY= locY;
    translate(answerX, answerY);
    //text(""+output, 0, -0.15*textAscent()); 
    text(""+output, 0, 0);
  }
  
  void output(Bit bit1, Bit bit2){
    updateInputs(bit1, bit2);
    updateOutput();
    System.out.println("output = " + this.output);
  }
  
  void updateInputs(TrackedObject bit1, TrackedObject bit2){
    this.input1 = bit1.value;
    this.input2 = bit2.value;
  }
  
  void updateOutput(){
    output = calculateOutput(input1, input2);
  }
  
  String toString() {
    return "\n input1: " + input1 + " input2: " + input2 + " output: " + output + "Logic gate type: And";
  }
}