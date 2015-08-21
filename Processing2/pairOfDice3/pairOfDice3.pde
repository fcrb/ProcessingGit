DiceModel model;

void setup() {
  size(480, 240);
  setBackground();
  model = new DiceModel();
  textSize(32);
  text("Click to roll.", 30, 70);
}

void draw() {
}  

void mousePressed() {
  setBackground();
}  

void mouseReleased() {
  setBackground();
  //Model should not draw. This is not real MVC yet.
  model.roll();
  model.draw(10, 10, height - 20);
}  

void setBackground() {
  background(50);
}

