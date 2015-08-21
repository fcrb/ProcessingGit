int[] bits;
int count=0;

void setup() {
  size(320, 80);
  frameRate(2);
  restart();
  int txtSize = 20;
  textSize(txtSize);
}

void draw() {
  background(0);
  addOne();
  String s = "";
  for (int b : bits) {
    s = b+s;
  }
  text("Binary:  "+s, height/4, height * 1 / 3);  
  text("Decimal: "+count, height/4, height * 2 / 3 );
}

void addOne() {
  ++count;
  for (int i = 0;i < bits.length; ++i) {
    if (bits[i] == 0) {
      bits[i] = 1; 
      return;
    }
    bits[i] = 0;
  }
}

void restart() {
  bits = new int[18];
  count = 0;
}

void setFramesPerSecond(int fps) {
  frameRate(fps);
}

