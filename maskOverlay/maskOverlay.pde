void setup() {
  size(640, 640);
}

void draw() {
  background(200, 200, 50);

  noStroke();
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, width/4, height/4);
  drawDemoMask();
}

void drawDemoMask() {
  fill(255);
  noSmooth();
  noStroke();
  int circlesPerRow = 5;
  int circlesPerColumn = 5;
  for (int i = 0; i < circlesPerColumn; ++i) {
    for (int j = 0; j < circlesPerRow; ++j) {
      ellipse((j+0.5) * width / (circlesPerRow ), (i+0.5) * height / (circlesPerColumn ), width/10, height/10);
    }
  }
}
