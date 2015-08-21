void setup() {
  size(1280, 900);
  background(255);
  noStroke();
  fill(0, 10);
}

void draw() {
  if (mousePressed) {
    float diameter = width * 0.1;
    ellipse(mouseX, mouseY, diameter, diameter);
  }
}

