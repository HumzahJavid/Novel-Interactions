class MathOperator extends DetectedObject {
  int rad=10;
  int size = 50;
  int id;

  MathOperator() {
  }

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
    String hexStr = Integer.toString(added, 16);
    fill(0);
    text("=", this.getX() + 45, this.getY());
    text("Denary: " + added + " | Hex: " + hexStr, this.getX() + 200, this.getY());
    int pos = 475;
    //170
    text("| Binary: ", this.getX() + 410, this.getY());
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
    boolean negative = false;
    int binaryTotal = 0;
    int added = 0;

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
    
    if(binaryOneNumber >= binaryTwoNumber){
      binaryTotal = binaryOneNumber - binaryTwoNumber;
    } else if(binaryOneNumber < binaryTwoNumber){
      binaryTotal = binaryTwoNumber - binaryOneNumber;
      negative = true;
    }
    
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
    if(negative == true){
      added = binaryTwoNumber - binaryOneNumber;
    } else if(negative == false){
      added = binaryOneNumber - binaryTwoNumber;
    }
    
    String hexStr = Integer.toString(added, 16);
    fill(0);
    text("=", this.getX() + 45, this.getY());
    if(negative == true){
      text("Denary: -" + added + " | Hex: " + hexStr, this.getX() + 215, this.getY());
    } else if(negative == false){
      text("Denary: " + added + " | Hex: " + hexStr, this.getX() + 215, this.getY());
    }
    int pos = 0;
     //  
    //
    
    if(negative == true){
      pos = 550;
      text("| Binary: -", this.getX() + 450, this.getY());
    } else if(negative == false){
      pos = 550;
      text("| Binary: ", this.getX() + 450, this.getY());
    }
    
    for (int i = 0; i < 8; i++) {
      text(binaryAdd[i], this.getX() + pos, this.getY());
      pos = pos + 20;
    }
    return 1;
  }

  public int mutiplication(Binary a, Binary b) {
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
    String hexStr = Integer.toString(added, 16);
    fill(0);
    text("=", this.getX() + 45, this.getY());
    text("Denary: " + added, this.getX() + 150, this.getY());
    text(" | Hex: " + hexStr, this.getX() + 300, this.getY());
    int pos = 530;
    text("| Binary: ", this.getX() + 450, this.getY());
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
    float divisionResult = 0.0;
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
    //prevents division by 0
    if (binaryTwoNumber == 0) {
      String denaryString = String.format("%s", "=  Denary: " + '\u221e' + " | Binary: " + '\u221e');
      text(denaryString, this.getX() + 205, this.getY());
      return 0;
    }

    int binaryTotal = binaryOneNumber / binaryTwoNumber;
    divisionResult = (float)(binaryOneNumber) / (float)(binaryTwoNumber);
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

    //the integer/characteristic part of the binary number
    int[]beforeDecimalPoint = removePadding(binaryAdd);
    int numberOfBitsAfterDecimalPoint = binaryAdd.length - beforeDecimalPoint.length;
    //the fractional/mantissa part of the binary number
    int[]afterDecimalPoint = calculateBitsAfterDecimal(divisionResult%1, numberOfBitsAfterDecimalPoint);

    String binaryString = "";
    for (int i = 0; i < beforeDecimalPoint.length; i++) {
      binaryString += beforeDecimalPoint[i];
    }
    binaryString +=".";
    for (int i = 0; i < afterDecimalPoint.length; i++) {
      binaryString += afterDecimalPoint[i];
    }

    String answerString = String.format("%s%.2f%s", "= Denary: ", divisionResult, " | Binary: "+ binaryString);
    fill(0);
    text(answerString, this.getX() + 290, this.getY());
    return 1;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  private int[] calculateBitsAfterDecimal(float decimal, int numberOfElements) {
    //calculates the binary number (given a number less than 1)
    float base = 2;
    float result;
    int[] arr = new int[numberOfElements];

    for (int i = 0; i < numberOfElements; i++) {
      //should stop filling the array when result = 0, but need to continue to keep size of final array 8 bits
      result = decimal*base;
      arr[i] = (int)result;
      decimal = result %1;
    }
    return arr;
  }

  private int[] removePadding(int[] binaryAdd) {
    //returns a new array with the leading zereos(padding) removed from the input array,
    int numberOfPaddingElements = 0;
    int length = binaryAdd.length;
    int endIndex = length;
    boolean valid = false;
    int[] newArr;

    for (int i = 0; i < length; i++) {
      //locates the first '1' in the array 
      if (binaryAdd[i] == 1) {
        valid = true;
        //removes all the '0' elements(the padding) preceeding the first '1' 
        for (int j = i; j < endIndex; j++) {
          binaryAdd[j - i] = binaryAdd[j];
        }
        //stores the index of the first '1' (in its original position).
        numberOfPaddingElements = i; 
        //to exit the loop
        i = endIndex;
      }
    }

    if (valid) {
      //end index with number of padding elements removed.
      endIndex -= numberOfPaddingElements;
      newArr = new int[endIndex];
      for (int i = 0; i < newArr.length; i++) {
        newArr[i] = binaryAdd[i];
      }
    } else {
      //To put a 0 before the decimal point
      newArr = new int[1];
    }
    return newArr;
  } 
}