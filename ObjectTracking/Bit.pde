public class Bit extends TrackedObject {   
  Bit() {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
  }


  Bit(String t) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text=t;
  }

  Bit(String t, int v) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text=t;
    this.value = v;
    this.id = -1;
  }

  Bit(String t, int v, int id) {
    rectCol=color(255, 50, 50);
    textCol=color(50, 50, 50);
    text=t;
    this.value = v;
    this.id = id;
  }

  public String toString() {
    return super.toString() + "TrackedObject type: Bit";
  }
}