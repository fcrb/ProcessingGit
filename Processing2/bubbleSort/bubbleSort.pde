int[] data;
int swapIndex = -1;

void setup() {
  size(640, 40);
  frameRate(5);
  data = new int[18];
  for(int i = 0; i < data.length; ++i) {
    data[i] = (int) random(100);
  }
}

void draw() {
  background(0);
  bubbleSwap(data);
  String s = "";
  for(int d : data) {
    s += " " + d;
  }
  int txtSize = 20;
  textSize(txtSize);
  text(s, txtSize, txtSize * 1.5);
}

void bubbleSwap(int[] input) {
  ++swapIndex;
  if (swapIndex >= input.length - 1) {
    swapIndex = 0;
  }
  if (input[swapIndex] > input[swapIndex + 1]) {
    int swap =   input[swapIndex];
    input[swapIndex] =   input[swapIndex + 1];
    input[swapIndex + 1] = swap;
  }
}
