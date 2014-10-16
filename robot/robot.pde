Robot robbie;

void setup() {
  size(640,480);
  robbie = new Robot();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  pushMatrix();
  drawGrid(-width/2, -height/2, 20, 100, 12);
  drawMouseCoordinates(-width/2, -height/2, 9);
  popMatrix();
  robbie.goTo(0, 0);
  robbie.draw();
}
