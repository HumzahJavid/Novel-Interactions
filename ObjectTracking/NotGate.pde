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
    drawOutputText();
    drawLineToInputs();
  }
  
  public void blankOutput() {
    input1 = new Bit("", -1);
    input2 = new Bit("", -1);
    updateOutput();
  }

  int calculateOutput(Bit bit1){
   // System.out.println("calculating output " + bit1.value);
    if(bit1.value != -1){
      if(bit1.value == 1){
        return 0;
      } else {
        return 1;
      }
    } else {
        return bit1.value;
    }
    
  }
  
  void drawLineToInputs(){
    //if both inputs are assigned a value
    if (input1.value != -1){
      float input1X = input1.getX();
      float input1Y = input1.getY();
      line(input1X, input1Y, this.getX(), this.getY());
    }
  }
  
  void drawOutputText(){
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
  
  void output(Bit bit1){
    updateInputs(bit1);
    updateOutput();
  }
  
  void updateInputs(Bit bit1){
    
   System.out.println("updatetinput " + bit1.value);
    this.input1 = bit1;
  }
  
  void updateOutput(){
    output = calculateOutput(input1);
  }
  
  String toString() {
    return "\n input1: " + input1 + " input2: " + input2 + " output: " + output + "Logic gate type: Not";
  }
}