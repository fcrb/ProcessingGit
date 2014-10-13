Robot robbie;

void setup() {
  size(640,480);
  robbie = new Robot();
}

void draw() {
  background(255);
  pushMatrix();
  translate(width/2, height/2);
  drawGrid(-width/2, -height/2, 20, 100, 12);
  drawMouseCoordinates(-width/2, -height/2, 9);
  popMatrix();
  robbie.goTo(mouseX, mouseY);
  robbie.draw();
}
