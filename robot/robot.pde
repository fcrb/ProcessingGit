Robot robbie;

void setup() {
  size(640,480);
  robbie = new Robot();
}

void draw() {
  background(255);
//  robbie.goTo(width/2, height/2);
  robbie.goTo(mouseX, mouseY);
  robbie.draw();
}
