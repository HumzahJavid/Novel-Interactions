class DetectedObject {
  float angle=0;
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
    rotate(angle);
    rect(0, 0, 60, 60, rad, rad, rad, rad);
    popMatrix();

    fill(textCol);
    text(text, locX, locY);
  }
  
  float getAngle() {
    return this.angle;
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
  
  void setAngle(float a) {
    angle=a;
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
    return " rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " rad: " + rad;
  }
}