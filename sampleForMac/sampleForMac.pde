int bgColor = color(150, 150, 255);
void setup() {
  size(640, 480);
  background(bgColor);
}

void draw() {
  noStroke();
  fill(255);

  ellipse(mouseX, mouseY, 100, 50);

  fill(bgColor, 80);
  rect(0, 0, width, height);
}
