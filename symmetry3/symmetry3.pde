ArrayList<Point> mousePositions;
int symmetry = 6;
int numberOfMousePositions = 30;
float alphaLevel = 30;

interface JavaScript {
  void showValues(int symmetry, int lag, float alphaLevel);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(640, 640);
  background(255);
  mousePositions = new ArrayList<Point>();
}

void draw() {
  if (javascript!=null) 
    javascript.showValues(symmetry, numberOfMousePositions, alphaLevel);
  fill(255, alphaLevel);
  if (!mousePressed)
    rect(0, 0, width, height);

  float xMid = width * 0.5;
  float yMid = height * 0.5;
  int c = frameCount % 512;
  c = min(c, 511 - c);
  stroke(0, 255 - c, c);
  mousePositions.add(new Point(mouseX, mouseY));
  if (mousePositions.size() > numberOfMousePositions)
    mousePositions.remove(0);
  for (int i = 0; i < symmetry; ++i) {
    float angle = i * 2 * PI / symmetry;
    float cosA = cos(angle);
    float sinA = sin(angle);
    float x = xMid + (mouseX - xMid) * cosA + (mouseY - yMid) * sinA;
    float y = yMid - (mouseX - xMid) * sinA + (mouseY - yMid) * cosA;
    float oldMouseX = mousePositions.get(0).x;
    float oldMouseY = mousePositions.get(0).y;
    float oldX = xMid + (oldMouseX - xMid) * cosA + (oldMouseY - yMid) * sinA;
    float oldY = yMid - (oldMouseX - xMid) * sinA + (oldMouseY - yMid) * cosA;
    line(x, y, oldX, oldY);
  }
}

class Point {
  float x, y;

  Point(float x_, float y_) {
    x = x_;
    y = y_;
  }
}

void setSymmetry(int n) {
  symmetry = n;
}

void setLag(int n) {
  numberOfMousePositions = n;
}

void setAlphaLevel(float a) {
  alphaLevel = a;
}
