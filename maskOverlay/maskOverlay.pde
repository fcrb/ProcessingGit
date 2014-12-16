void setup() {
  size(640, 160);
}

void draw() {
  background(200, 200, 50);

  noStroke();
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, width/4, width/4);
  drawDemoMask();
}

void drawDemoMask() {
  fill(255, 200);
  noSmooth();
  noStroke();
  int circlesPerRow = 12;
  int circlesPerColumn = 3;
  for (int i = 0; i < circlesPerColumn; ++i) {
    for (int j = 0; j < circlesPerRow; ++j) {
      ellipse((j+0.5) * width / (circlesPerRow ), (i+0.5) * height / (circlesPerColumn ), height/5, height/5);
    }
  }
}
