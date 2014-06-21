float oldMouseX , oldMouseY;

void setup() {
  size(640, 640);
  background(255);
  oldMouseX = mouseX;
  oldMouseY = mouseY;
}

void draw() {
  fill(255,30);
  if(!mousePressed)
    rect(0,0,width,height);

  int symmetry = 16;
  float xMid = width * 0.5;
  float yMid = height * 0.5;
  int c = frameCount % 512;
  c = min(c, 511 - c);
  stroke(255, 255 - c, c);
  for (int i = 0; i < symmetry; ++i) {
    float angle = i * 2 * PI / symmetry;
    float cosA = cos(angle);
    float sinA = sin(angle);
    float x = xMid + (mouseX - xMid) * cosA + (mouseY - yMid) * sinA;
    float y = yMid - (mouseX - xMid) * sinA + (mouseY - yMid) * cosA;
    float oldX = xMid + (oldMouseX - xMid) * cosA + (oldMouseY - yMid) * sinA;
    float oldY = yMid - (oldMouseX - xMid) * sinA + (oldMouseY - yMid) * cosA;
    line(x, y, oldX, oldY);
  }
  oldMouseX = mouseX;
  oldMouseY = mouseY;
}
