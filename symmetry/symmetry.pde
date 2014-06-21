float xPrevious = -1, yPrevious = -1;

void setup() {
  size(640, 640);
  background(255);
}

void draw() {
  fill(255,8);
  rect(0,0, width, height);

  int symmetry = 6;
  float xMid = width * 0.5;
  float yMid = height * 0.5;
  for (int i = 0; i < symmetry; ++i) {
    float angle = i * 2 * PI / symmetry;
    float cosA = cos(angle);
    float sinA = sin(angle);
    float x = xMid + (mouseX - xMid) * cosA + (mouseY - yMid) * sinA;
    float y = yMid - (mouseX - xMid) * sinA + (mouseY - yMid) * cosA;
    if (xPrevious > 0) {
      line(x, y, xPrevious, yPrevious);
    }
    xPrevious = x;
    yPrevious = y;
  }
}
