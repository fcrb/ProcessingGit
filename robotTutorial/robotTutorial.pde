Robot robbie;
Robot robbiesLittleBrother;

void setup() {
  size(800, 600);
  robbie = new Robot();
  robbiesLittleBrother = new Robot();
}

void draw() {
  background(255);

  robbie.moveTo(mouseX, mouseY);
  robbie.draw();
}
