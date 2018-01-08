class MathOperator extends DetectedObject {
  float angle=0;
  color rectCol;
  color textCol;
  String text = " ";
  int locX, locY;
  int rad=10;

  MathOperator(String operator) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    this.text = operator;
  }

  public int calculate(Binary b1, Binary b2) {
    switch(this.text) {
    case "+":
      addition(b1, b2);
    case "-":
      subtraction(b1, b2);
    case "*": 
      mutiplication(b1, b2);
    case "/":
      division(b1, b2);
      break;
    }
    return 0;
  }

  public Binary addition(Binary a, Binary b) {
    int c[] = new int[a.size() + 1];
    int carry = 0;
    for (int i = a.size() - 1; i > -1; i--) { // i 1
      c[i + 1] = (a.getValue(i) + b.getValue(i) + carry) % 2;// c[2]
      carry = (a.getValue(i) + b.getValue(i)) / 2;
    }
    c[0] = carry;
    System.out.println(" carry = " + carry);
    ArrayList<Bit> resultBits = new ArrayList<Bit>();
    for(int number : c){
      resultBits.add(new Bit(""+number));
    }
    Binary result = new Binary(resultBits);
    return result;
  }

  public Binary subtraction(Binary a, Binary b) {
    return null;
  }

  public Binary mutiplication(Binary a, Binary b) {
    return null;
  }

  public Binary division(Binary a, Binary b) {
    return null;
  }
}