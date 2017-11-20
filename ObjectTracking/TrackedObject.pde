class TrackedObject {
  color rectCol;
  color textCol;

  String text = " ";

  int locX, locY;
  float angle=0;
  int size=60;
  int rad=10;
  int value = -1;
  int id = -1;
  TrackedObject() {

    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);

    text=" ";
  }
  TrackedObject(String t) {

    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);

    text=t;
  }

  public TrackedObject(String t, int v) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text=t;
    this.value = v;
  }

  public TrackedObject(String t, int v, int id) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text=t;
    this.value = v;
    this.id = id;
  }

  void draw() {
    //rectMode(CENTER);
    noFill();
    stroke(rectCol);

    pushMatrix();
    translate(locX, locY);
    rotate(angle);
    rect(0, 0, size, size, rad, rad, rad, rad);
    popMatrix();

    fill(textCol);
    text(text, locX, locY);
  }

  int getX() {
    return this.locX;
  }

  int getY() {
    return this.locY;
  }

  String getText() {
    return this.text;
  }
  
  int getValue() {
    return this.value;
  }
  
  int getId() {
    return this.id;
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

  void setValue(int v) {
    this.value = v;
  }

  void setId(int id) {
    this.id = id;
  }

  void setAngle(float a) {
    angle=a;
  }

  String toString() {
    return " id: " + id + " value: " + value +  
      "\n rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " angle " + angle + " size: " + size + " rad: " + rad
      + " TrackedObject type: TrackedObject";
  }
}