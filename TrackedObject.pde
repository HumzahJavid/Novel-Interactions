class TrackedObject{
  color rectCol;
  color textCol;
  
  String text;
  
  int locX, locY;
  float angle=0;
  int size=60;
  int rad=10;
 
 TrackedObject(String t){
   
  rectCol=color(255, 50, 50);
  textCol=color(50, 50, 50);
  
  text=t;

 }
  
  void draw(){
    noFill();
    stroke(rectCol);

    pushMatrix();
    translate(locX, locY);
    println("angle is " + angle);
    rotate(angle);
    rect(0, 0, size, size, rad);
    popMatrix();

    fill(textCol);
    text(text, locX, locY); 
    
  }
  
  void setPos(int x, int y){
    locX=x; locY=y; 
  }
  
  void shiftPos(int dx, int dy){
    locX+=dx; locY+=dy;
  }
  
  void setAngle(float a){
    angle=a;
  }
}