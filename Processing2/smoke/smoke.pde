void setup() {
  size(320, 240);
  background(0);
}

void draw() {
  float diameter = 20;
  fill(255);
  ellipse(mouseX, mouseY, diameter, diameter);
  noStroke();
  fill(0, 0, 0, 10);
  rect(0,0,width, height);
}
