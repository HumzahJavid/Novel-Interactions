class DetectedObject {
  color rectCol;
  color textCol;

  String text = " ";

  int locX, locY;
  int rad=10;

  public DetectedObject() {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text=" ";
  }

  public DetectedObject(int x, int y) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text=" ";
    locX = x;
    locY = y;
  }

  void draw() {
    noFill();
    stroke(rectCol);

    pushMatrix();
    translate(locX, locY);
    rect(0, 0, 60, 60, rad, rad, rad, rad);
    popMatrix();

    fill(textCol);
    text(text, locX, locY);
  }

  String getText() {
    return this.text;
  }

  int getX() {
    return this.locX;
  }

  int getY() {
    return this.locY;
  }

  void setPos(int x, int y) {
    locX=x; 
    locY=y;
  }

  void shiftPos(int dx, int dy) {
    locX+=dx; 
    locY+=dy;
  }

  void setText(String t) {
    this.text = t;
  }
  
  String toString() {
    return " rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " rad: " + rad
      + " TrackedObject type: DetectedObject";
  }
/*
  String toString() {
    return " id: " + id + " value: " + value +  
      "\n rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " angle " + angle + " width: " + width + " height" + height + " rad: " + rad
      + " TrackedObject type: DetectedObject";
  }*/
}