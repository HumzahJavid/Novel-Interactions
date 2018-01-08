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

  //addition
  public void addition(int[] a, int[] b) {

    int c[] = new int[a.length + 1];
    int carry = 0;
    for (int i = a.length - 1; i > -1; i--) { // i 1
      c[i + 1] = (a[i] + b[i] + carry) % 2;// c[2]
      carry = (a[i] + b[i]) / 2;
      
    }
    
    c[0] = carry;
    System.out.println(" carry = " + carry);
    printArr(c);
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