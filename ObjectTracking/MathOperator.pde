class MathOperator extends DetectedObject {
  int rad=10;
  int size = 50;
  int id;

  MathOperator(String operator) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    this.text = operator;
  }

  void draw() {
    noFill();
    stroke(rectCol);

    rect(locX, locY, size, size, rad, rad, rad, rad);
    fill(textCol);
    text(text, locX, locY);
  }

  public int calculate(Binary b1, Binary b2) {
    switch(this.text) {
    case "+":
      addition(b1, b2);
      break;
    case "-":
      subtraction(b1, b2);
      break;
    case "*": 
      mutiplication(b1, b2);
      break;
    case "/":
      division(b1, b2);
      break;
    }
    return 0;
  }

  public int addition(Binary a, Binary b) {
    int[] binaryAdd = new int[8];
    int[] bin1 = new int[4];
    int[] bin2 = new int[4];
    int binaryOneNumber = 0;
    int binaryTwoNumber = 0;
    int binaryValue = 8;

    for (int i = 0; i < 4; i++) {
      bin1[i] = a.getValue(i);
      bin2[i] = b.getValue(i);
    }
    for (int i = 0; i < 4; i++) {
      if (bin1[i] == 1) {
        binaryOneNumber = binaryOneNumber + binaryValue;
      }
      if (bin2[i] == 1) {
        binaryTwoNumber = binaryTwoNumber + binaryValue;
      }
      binaryValue = binaryValue / 2;
    }
    int binaryTotal = binaryOneNumber + binaryTwoNumber;
    int binary8Bit = 128;

    for (int i = 0; i < 8; i++) {
      if (binaryTotal >= binary8Bit) {
        binaryAdd[i] = 1;
        binaryTotal = binaryTotal - binary8Bit;
      } else { 
        binaryAdd[i] = 0;
      }
      binary8Bit = binary8Bit / 2;
    }
    int added = binaryOneNumber + binaryTwoNumber;
    fill(0);
    text("=", this.getX() + 45, this.getY());
    text("Denary: " + added, this.getX() + 150, this.getY());
    int pos = 370;
    text("| Binary: ", this.getX() + 300, this.getY());
    for (int i = 0; i < 8; i++) {
      text(binaryAdd[i], this.getX() + pos, this.getY());
      pos = pos + 20;
    }
    return 1;
  }

  public int subtraction(Binary a, Binary b) {
    int[] binaryAdd = new int[8];
    int[] bin1 = new int[4];
    int[] bin2 = new int[4];
    int binaryOneNumber = 0;
    int binaryTwoNumber = 0;
    int binaryValue = 8;

    for (int i = 0; i < 4; i++) {
      bin1[i] = a.getValue(i);
      bin2[i] = b.getValue(i);
    }
    for (int i = 0; i < 4; i++) {
      if (bin1[i] == 1) {
        binaryOneNumber = binaryOneNumber + binaryValue;
      }
      if (bin2[i] == 1) {
        binaryTwoNumber = binaryTwoNumber + binaryValue;
      }
      binaryValue = binaryValue / 2;
    }
    int binaryTotal = binaryOneNumber - binaryTwoNumber;
    int binary8Bit = 128;

    for (int i = 0; i < 8; i++) {
      if (binaryTotal >= binary8Bit) {
        binaryAdd[i] = 1;
        binaryTotal = binaryTotal - binary8Bit;
      } else { 
        binaryAdd[i] = 0;
      }
      binary8Bit = binary8Bit / 2;
    }
    int added = binaryOneNumber - binaryTwoNumber;
    fill(0);
    text("=", this.getX() + 45, this.getY());
    text("Denary: " + added, this.getX() + 150, this.getY());
    int pos = 370;
    text("| Binary: ", this.getX() + 300, this.getY());
    for (int i = 0; i < 8; i++) {
      text(binaryAdd[i], this.getX() + pos, this.getY());
      pos = pos + 20;
    }
    return 1;
  }

  public int  mutiplication(Binary a, Binary b) {
    int[] binaryAdd = new int[8];
    int[] bin1 = new int[4];
    int[] bin2 = new int[4];
    int binaryOneNumber = 0;
    int binaryTwoNumber = 0;
    int binaryValue = 8;

    for (int i = 0; i < 4; i++) {
      bin1[i] = a.getValue(i);
      bin2[i] = b.getValue(i);
    }
    for (int i = 0; i < 4; i++) {
      if (bin1[i] == 1) {
        binaryOneNumber = binaryOneNumber + binaryValue;
      }
      if (bin2[i] == 1) {
        binaryTwoNumber = binaryTwoNumber + binaryValue;
      }
      binaryValue = binaryValue / 2;
    }
    int binaryTotal = binaryOneNumber * binaryTwoNumber;
    int binary8Bit = 128;

    for (int i = 0; i < 8; i++) {
      if (binaryTotal >= binary8Bit) {
        binaryAdd[i] = 1;
        binaryTotal = binaryTotal - binary8Bit;
      } else { 
        binaryAdd[i] = 0;
      }
      binary8Bit = binary8Bit / 2;
    }
    int added = binaryOneNumber * binaryTwoNumber;
    fill(0);
    text("=", this.getX() + 45, this.getY());
    text("Denary: " + added, this.getX() + 150, this.getY());
    int pos = 370;
    text("| Binary: ", this.getX() + 300, this.getY());
    for (int i = 0; i < 8; i++) {
      text(binaryAdd[i], this.getX() + pos, this.getY());
      pos = pos + 20;
    }
    return 1;
  }

  public int division(Binary a, Binary b) {
    int[] binaryAdd = new int[8];
    int[] bin1 = new int[4];
    int[] bin2 = new int[4];
    int binaryOneNumber = 0;
    int binaryTwoNumber = 0;
    int binaryValue = 8;

    for (int i = 0; i < 4; i++) {
      bin1[i] = a.getValue(i);
      bin2[i] = b.getValue(i);
    }
    for (int i = 0; i < 4; i++) {
      if (bin1[i] == 1) {
        binaryOneNumber = binaryOneNumber + binaryValue;
      }
      if (bin2[i] == 1) {
        binaryTwoNumber = binaryTwoNumber + binaryValue;
      }
      binaryValue = binaryValue / 2;
    }
    int binaryTotal = binaryOneNumber / binaryTwoNumber;
    int binary8Bit = 128;

    for (int i = 0; i < 8; i++) {
      if (binaryTotal >= binary8Bit) {
        binaryAdd[i] = 1;
        binaryTotal = binaryTotal - binary8Bit;
      } else { 
        binaryAdd[i] = 0;
      }
      binary8Bit = binary8Bit / 2;
    }
    int added = binaryOneNumber / binaryTwoNumber;
    fill(0);
    text("=", this.getX() + 45, this.getY());
    text("Denary: " + added, this.getX() + 150, this.getY());
    int pos = 370;
    text("| Binary: ", this.getX() + 300, this.getY());
    for (int i = 0; i < 8; i++) {
      text(binaryAdd[i], this.getX() + pos, this.getY());
      pos = pos + 20;
    }
    return 1;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }
}
/*
public static void binarySub(int[] a, int[] b) {
 int fakeDecimal = 0;
 int c[] = new int[a.length];
 for (int i = a.length-1; i > -1; i--) {
 
 // returns-1
 c[i] = (a[i] - b[i]);
 System.out.println(" a (" + a[i] + ") -  b(" + b[i] + ") = ");
 
 System.out.println("C "+ c[i]);
 if ((c[i] == -1) && (i != 0)){
 c[i] = 1;
 }
 }
 
 for (int i = 0; i < a.length; i++) {
 fakeDecimal = fakeDecimal * 2 + (a[i] - b[i] - 0);
 // System.out.print(decimal);
 }
 System.out.println("fake decimal = " + fakeDecimal);
 
 printArr(c);
 toDec(c);
 
 }*/