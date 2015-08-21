float perlinSpaceIncrement = 0.002;
float perlinTimeIncrement = 0.04;

void setup() {
  size(480, 270);
  noSmooth();
}

void draw() {
  drawUsingPixels();
}

void drawUsingPixels() {
  background(0);
  loadPixels();
  float t = frameCount * perlinTimeIncrement;
  for (int i = 0; i < width; ++i) {
    float x = i * perlinSpaceIncrement;
    for (int j = 0; j < height; ++j) {
      float y = j * perlinSpaceIncrement;
      float r = noise(x, y, t)*255;
      float g = noise(x+10, y+20, t)*255;
      float b = noise(x+30, y+40, t)*255;
      pixels[i + width * j] = color(r, g, b);
    }
  }
  updatePixels();
  fill(255);
  text("fps = "+(int) (frameCount * 1000.0)/millis(), 20, 20);
}

void drawUsingPoint() {
  background(0);
  for (int i = 0; i < width; ++i) {
    for (int j = 0; j < height; ++j) {
      float t = frameCount * perlinTimeIncrement;
      float x = i * perlinSpaceIncrement;
      float y = j * perlinSpaceIncrement;
      float r = noise(x, y, t)*255;
      float g = noise(x+10, y+20, t)*255;
      float b = noise(x+30, y+40, t)*255;
      stroke(r, g, b);
      point(i, j);
    }
  }
  fill(255);
  int fps = round((frameCount * 1000.0)/millis());
  text("fps = "+ fps, 20, 20);
}

