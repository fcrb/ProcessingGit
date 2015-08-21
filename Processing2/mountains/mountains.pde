void setup() {
  size(640, 480);
}

void draw() {
}

void keyPressed() {
  drawFrame();
}

void drawFrame() {
  background(255);
  int numMountainRanges = 6;
  for (int rangeCtr = 1; rangeCtr <= numMountainRanges; ++rangeCtr) {
    int greyLevel = 256 - rangeCtr * 256 / numMountainRanges;
    int rangeColor = color(greyLevel, greyLevel, greyLevel); 
    drawRange(rangeColor, 8);
  }
}

void drawRange(int rangeColor, float dy) {
  float y = height/2; //random(height);
  fill(rangeColor);
  noStroke();
  beginShape();
  for (int x = 0; x <= width; ++x) {
    y += random(dy) - dy/2;
    vertex(x, y);
  }
  vertex(width, height);
  vertex(0, height);
  endShape();
}
