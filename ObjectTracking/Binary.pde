class Binary {
  color rectCol;
  color textCol;

  String text = " ";

  int locX, locY;
  float angle=0;
  int height=60;
  int width=height*2;//maxlength
  int rad=10;
  int value = 0000;
  int id = -1;
  int size;

  private final int MAXIMUM_LENGTH = 4;
  ArrayList<TrackedObject> bits = new ArrayList<TrackedObject>(MAXIMUM_LENGTH);

  public Binary() {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text="_ _ _ _";
    locX = width / 2;
    locY = height / 2;
  }

  public Binary(int x, int y) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text="_ _ _ _";
    locX = x;
    locY = y;
  }

  public Binary(ArrayList<TrackedObject> bits) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text="_ _ _ _";
    this.bits.addAll(bits);
    locX = width / 2;
    locY = height / 2;
  }

  void draw() {
    //need to position text in center of rectsomehow
    //rectMode(CENTER);
    textAlign(CENTER, CENTER);
    noFill();
    stroke(rectCol);

    pushMatrix();
    translate(locX, locY);
    rotate(angle);
    rect(0, 0, width, height, rad, rad, rad, rad);
    //rect(width/2, height/2, width, height, rad, rad, rad, rad);
    popMatrix();
    this.updateText3();
    fill(textCol);
    text(text, locX, locY);
    //System.out.println("locationX Y = " + locX + " " + locY);
  }

  void setPos(int x, int y) {
    locX=x; 
    locY=y;
  }

  void shiftPos(int dx, int dy) {
    locX+=dx; 
    locY+=dy;
  }

  void setAngle(float a) {
    angle=a;
  }

  String getText() {
    return this.text;
  }

  int getId() {
    return this.id;
  }

  int getValue() {
    return this.value;
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

  void add(TrackedObject bit) {
    if (this.bits.size() < MAXIMUM_LENGTH) {
      this.bits.add(bit);
    } else {
      System.out.println("BINARY VALUE IS FULL");
      //project to screen draw an X over the binary number momentarily
    }
    //this.updateText3(); //put in if for add and remove more efficient;
  }

  void remove(TrackedObject bit) {
    if (this.bits.size() > 0) {
      this.bits.remove(bit);
    } else {
      System.out.println("BINARY VALUE IS EMPTY");
    }
    //this.updateText3();
  }

  private void updateText() {
    String updatedText = "";
    for (TrackedObject bit : bits) {
      System.out.println("bit.value = " + bit.value);
      updatedText += bit.value;
      System.out.println("updatedText so far " + updatedText);
    }
    text = updatedText;
  }

  private void updateText2() {
    String updatedText = "_ _ _ _"; //change to the current value
    System.out.println("updatedText.length = " + updatedText.length());
    char[] textChars = updatedText.toCharArray();
    int length = textChars.length;
    System.out.println("textChars = " + length);
    int index = length;


    //replace _ with each element of bits
    for (TrackedObject bit : bits) {
      //find the next _ char index starting from theRHS
      for (int i = length - 1; i > -1; i--) {
        System.out.println(textChars[i]);
        if (textChars[i] == '_') {
          System.out.println("found  char _" + textChars[i] + " at index " + index);
          index = i;
          //exit loop
          i = -1;
        }
      }

      //i want to store either a 0 or 1 into the textChars at the correct index
      //'0' as a char has value 48
      //the cast is (0 + 48) or (1 + 48) which gives currentChar= 0 or 1 
      char currentChar = (char)(bit.value + '0');
      textChars[index] = currentChar;
      System.out.println("current chars so far = " + String.valueOf(textChars));
    }
    System.out.println("finally text is " + text);
    text = String.valueOf(textChars);
  }

  private void updateText3() {
    StringBuilder updatedText = new StringBuilder("_ _ _ _"); //change to the current value
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
    //System.out.println("The updated text is " + text);
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
    return " id: " + id + " value: " + value +  
      "\n rectCol: " + rectCol + " textCol: " + textCol + " locX: " + locX + " locY " + locY + " angle " + angle + " width: " + width + " height" + height + " rad: " + rad
      + " TrackedObject type: Binary";
  }
}