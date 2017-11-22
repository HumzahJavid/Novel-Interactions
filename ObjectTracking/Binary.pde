class Binary extends DetectedObject {
  int height=60;
  int width=height*2;
  int locX = width / 2;
  int locY = height / 2;
  String text = "_ _ _ _";

  private final int MAXIMUM_LENGTH;
  ArrayList<TrackedObject> bits = new ArrayList<TrackedObject>();

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

  public Binary(ArrayList<TrackedObject> bits) {
    MAXIMUM_LENGTH = bits.size();
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    bits.addAll(bits);
    locX = width / 2;
    locY = height / 2;
  }

  void draw() {
    textAlign(CENTER, CENTER);
    noFill();
    stroke(rectCol);

    pushMatrix();
    translate(locX, locY);
    rect(0, 0, width, height, rad, rad, rad, rad);
    popMatrix();
    updateText();
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

  void add(TrackedObject bit) {
    if (this.bits.size() < MAXIMUM_LENGTH) {
      this.bits.add(bit);
    } else {
      System.out.println("BINARY VALUE IS FULL");
    }
  }

  void remove(TrackedObject bit) {
    if (this.bits.size() > 0) {
      this.bits.remove(bit);
    } else {
      System.out.println("BINARY VALUE IS EMPTY");
    }
  }

  private void updateText() {
    //will not need to run this until the binary number values(# bits) are full
    StringBuilder updatedText = new StringBuilder("_ _ _ _");
    int length = updatedText.length();
    int index = length;
    char bitChar = ' ';

    //replace _ with each element of bits
    for (TrackedObject bit : bits) {
      if (bit.value == 0) {
        bitChar = '0';
      } else {
        bitChar = '1';
      }
      //find the index of the next "_" char from the RHS
      for (int i = length - 1; i > -1; i-=2) {
        if (updatedText.charAt(i) == '_') {
          index = i;
          //to exit the loop
          i = -1;
        }
      }
      updatedText.setCharAt(index, bitChar);
    }
    //fills the binary values in correct order swapping values is fine aswell
    //but starts filling from the most signifcant bit 
    //updatedText = updatedText.reverse();
    text = updatedText.toString();
  }

  int size() {
    return bits.size();
  }

  boolean contains(TrackedObject bit) {
    return bits.contains(bit);
  }
  
  public void sort(Comparator<TrackedObject> comp) {
    Collections.sort(this.bits, comp);
    //updateText3();
  }
  
  String toString() {
    return "rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " width: " + width + " height" + height + " rad: " + rad
      + " TrackedObject type: Binary";
  }
}