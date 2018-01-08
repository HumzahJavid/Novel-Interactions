public class MathOperator {
  int a[] = {1, 1, 1};
  int b[] = {1, 1, 0};
  int i;
  int decimal;


  for (i = 0, decimal = 0; i < a.length; i++) {
    decimal = decimal * 2 + (a[i] - b[i] - 0);
    // System.out.print(decimal);
  }


  System.out.println(" Addition");
  binaryAdd(a, b);


  System.out.println("   ");
  System.out.println(" -------------------  ");

  //addition
  public static void binaryAdd(int[] a, int[] b) {

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
}