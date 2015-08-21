void setup() {
  size(640, 480);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  drawGrid(-width/2, -height/2, 20, 100, 12);
  drawMouseCoordinates(-width/2, -height/2, 9);
}
