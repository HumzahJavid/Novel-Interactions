class Binary extends DetectedObject {
  int height=60;
  int width=height*2;
  int locX = width / 2;
  int locY = height / 2;
  String text = "";
  String decimalString;
  String hexString;

  private final int MAXIMUM_LENGTH;
  ArrayList<Bit> bits = new ArrayList<Bit>();

  public Binary(int maxLength) {
    MAXIMUM_LENGTH = maxLength;
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
  }

  public Binary(int maxLength, int x, int y) {
    MAXIMUM_LENGTH = maxLength;
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    locX = x;
    locY = y;
  }

  public Binary(ArrayList<Bit> bits1) {
    
    println("created binay obj " + bits1);
    MAXIMUM_LENGTH = bits.size();
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    this.bits.addAll(bits1);
    locX = width / 2;
    locY = height / 2;
    
    updateText();
    conversion();
    println(this.decimalString, this.hexString);
  }

  public void conversion() {
    //Converts a binary string to a decimal number
    int decimalNum = Integer.parseInt(this.text, 2);
    //Converts decimal number into hexidecimal string 
    String hexStr = Integer.toString(decimalNum, 16);
    String decimalStr = "" + decimalNum;
    this.decimalString = decimalStr;
    this.hexString = hexStr;
  }

  void draw() {
    textAlign(CENTER, CENTER);
    noFill();
    stroke(rectCol);

    pushMatrix();
    translate(locX, locY);
    rect(0, 0, width, height, rad, rad, rad, rad);
    //rect(0, 250, width, height, rad, rad, rad, rad);
    popMatrix();
    fill(textCol);
    text(text, locX, locY);
  }

  void setPos(int x, int y) {
    locX=x; 
    locY=y;
  }

  void shiftPos(int dx, int dy) {
    locX+=dx; 
    locY+=dy;
  }

  String getText() {
    return this.text;
  }

  void setText(String t) {
    this.text = t;
  }

  void add(Bit bit) {
    if (this.bits.size() < MAXIMUM_LENGTH) {
      this.bits.add(bit);
    } else {
      System.out.println("BINARY VALUE IS FULL");
    }
  }

  void remove(Bit bit) {
    if (this.bits.size() > 0) {
      this.bits.remove(bit);
    } else {
      System.out.println("BINARY VALUE IS EMPTY");
    }
  }

  private void updateText() {
    //will not need to run this until the binary number values(# bits) are full
    println("UPDATETEXT START");
    println(bits);
    
    String updatedText = "";
    
    for (Bit bit : this.bits) {
      updatedText+= bit.value;
      println("bit value: " + bit.value);
    }
    this.text = updatedText;
    println("Updatedtext: " + updatedText);
  }
      

  int size() {
    return bits.size();
  }

  boolean contains(Bit bit) {
    return bits.contains(bit);
  }

  public void sort(Comparator<Bit> comp) {
    Collections.sort(this.bits, comp);
    //updateText3();
  }

  String toString() {
    return "rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " width: " + width + " height" + height + " rad: " + rad
      + " Bit type: Binary";
  }
}