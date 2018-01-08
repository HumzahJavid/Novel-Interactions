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
    case "-":
      subtraction(b1, b2);
    case "*": 
      mutiplication(b1, b2);
      break;
    }
    return 0;
  }

  public Binary addition(Binary a, Binary b) {
    println("running addition function with " + a + " " + b);
    int c[] = new int[a.size() + 1];
    int carry = 0;
    for (int i = a.size() - 1; i > -1; i--) { // i 1
      c[i + 1] = (a.getValue(i) + b.getValue(i) + carry) % 2;// c[2]
      carry = (a.getValue(i) + b.getValue(i)) / 2;
    }
    c[0] = carry;
    System.out.println(" carry = " + carry);
    ArrayList<Bit> resultBits = new ArrayList<Bit>();
    for (int number : c) {
      resultBits.add(new Bit(""+number));
    }
    
    System.out.println(" result is  = " + resultBits);
    Binary result = new Binary(resultBits);
    return result;
  } 

  public Binary subtraction(Binary a, Binary b) {
    return null;
  }

  public Binary mutiplication(Binary a, Binary b) {
    return null;
  }
  
  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }
}