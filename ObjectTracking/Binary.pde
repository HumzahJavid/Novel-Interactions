class Binary extends DetectedObject {
  int height=60;
  int width=height*2;
  int locX = width / 2;
  int locY = height / 2;
  String text = "";
  String decimalString = "";
  String hexString = "";
  //whether to draw the binary
  boolean alive = false;

  Comparator<Bit> compX = new Comparator<Bit>() {
    public int compare(Bit o1, Bit o2) {
      if (o1.getX()<o2.getX()) { 
        return -1;
      } else if (o1.getX()>o2.getX()) { 
        return 1;
      } else { 
        return 0;
      }
    }
  };

  Comparator<Bit> compY = new Comparator<Bit>() {
    public int compare(Bit o1, Bit o2) {
      if (o1.getY()<o2.getY()) { 
        return -1;
      } else if (o1.getY()>o2.getY()) { 
        return 1;
      } else { 
        return 0;
      }
    }
  };

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
    MAXIMUM_LENGTH = bits.size();
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    this.bits = bits1;
    locX = width / 2;
    locY = height / 2;
  }

  public void applyColour() {
    if (this.text == "") {
      println("number conversion NOT running");
    } else {
      color textCol=color(50, 50, 50);
      fill(textCol);

      int R = 0;
      int G = 0;
      int B = 0;

      if (this.bits.get(0).getValue() == 1) {
        R = 255;
      } else {
        R = 0;
      }

      if (this.bits.get(1).getValue() == 1) {
        G = 255;
      } else {
        G = 0;
      }

      if (this.bits.get(2).getValue() == 1) {
        B = 255;
      } else {
        B = 0;
      }

      if (this.bits.get(3).getValue() == 1) {
        if (R == 255) {
          R = 130;
        }
        if (G == 255) {
          G = 130;
        }
        if (B == 255) {
          B = 130;
        }
      }

      rectMode(CENTER);
      pushMatrix();
      rectMode(CORNER);
      noStroke();
      fill(R, G, B);
      rect(bits.get(0).getX() - 50, bits.get(0).getY() + 70, bits.get(3).getX() - 50, 100, 10);
      popMatrix();
      rectMode(CENTER);
    }
  }

  public void numberConversion() {
    if (this.text == "") {
      println("number conversion NOT running");
    } else {
      //Converts a binary string to a decimal number
      int decimalNum = Integer.parseInt(this.text, 2);
      //Converts decimal number into hexidecimal string 
      String hexStr = Integer.toString(decimalNum, 16);
      String decimalStr = "" + decimalNum;
      this.decimalString = decimalStr;
      this.hexString = hexStr;
      //Displays number conversions for a given binary number
      text("Denary: " + decimalString + " | Hex: " + hexString.toUpperCase(), bits.get(0).getX()+135, bits.get(0).getY()-80);
    }
  }

  void draw() {
    if (this.alive) {
      textAlign(CENTER, CENTER);
      noFill();
      drawBoundary();
      binaryText();
      numberConversion();
      fill(textCol);
      applyColour();
    } else {
      //need to check whether the boundary should be drawn in the next frame(check if alive)
      drawBoundary();
    }
  }

  void drawBoundary() {
    ;
    ArrayList<Bit> bitsClone = new ArrayList<Bit>();
    bitsClone.addAll(this.bits);
    Collections.sort(bitsClone, compY);

    int binTwoFirst = this.bits.get(0).getX();
    int binTwoLast = this.bits.get(3).getX();
    int binTwoYFirst = this.bits.get(0).getY();
    int binTwoYLast = this.bits.get(3).getY();
    if (binTwoLast - binTwoFirst < 350 && binTwoYLast - binTwoYFirst < 75) {
      println("ITs alive");
      this.alive = true;
      rectMode(CENTER);
      pushMatrix();
      rectMode(CORNER);
      noFill();
      rect(binTwoFirst - 50, binTwoYLast + 50, binTwoLast - binTwoFirst + 100, binTwoYFirst - binTwoYLast - 100, 10);
      popMatrix();
      rectMode(CENTER);
    } else {
      this.alive = false;
      println("ITs dead");
    }
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

  private void binaryText() {
    String binaryText = "";
    for (Bit bit : this.bits) {
      binaryText+= bit.value;
    }
    this.text = binaryText;
  }

  int size() {
    return bits.size();
  }

  boolean contains(Bit bit) {
    return bits.contains(bit);
  }

  public void sort(Comparator<Bit> comp) {
    Collections.sort(this.bits, comp);
  }

  String toString() {
    return "rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " width: " + width + " height" + height + " rad: " + rad
      + " Bit type: Binary";
  }
}