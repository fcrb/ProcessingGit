float X_MIN = -10;
float X_MAX = 10;
float Y_MIN = -10;
float Y_MAX = 10;
float X_GRID = 1;
float Y_GRID = 1;
float TEXT_SIZE = 18;

int currentStroke = 0;
int currentStrokeWeight = 1;

void drawAxes() {
  stroke(0);
  strokeWeight(0.5);
  drawLine(0, Y_MIN, 0, Y_MAX);
  drawLine(X_MIN, 0, X_MAX, 0);
  stroke(currentStroke);
  strokeWeight(currentStrokeWeight);
}

void drawGrid() {
  stroke(200);
  strokeWeight(0.5);
  float x = X_MIN;
  while (x < X_MAX) {
    drawLine(x, Y_MIN, x, Y_MAX);
    x += X_GRID;
  }

  float y = Y_MIN;
  while (y < Y_MAX) {
    drawLine(X_MIN, y, X_MAX, y);
    y += Y_GRID;
  }

  stroke(currentStroke);
  strokeWeight(currentStrokeWeight);
}

void xLimits(float xMin, float xMax) {
  X_MIN = xMin;
  X_MAX = xMax;
}

void yLimits(float yMin, float yMax) {
  Y_MIN = yMin;
  Y_MAX = yMax;
}

void drawCircle(float x0, float y0, float radius) {
  pushMatrix();
  float r = mapLength(radius);
  noFill();
  ellipse(mapX(x0), mapY(y0), r * 2, r * 2);
  popMatrix();
}

void drawFunction(Function f, int numSteps) {
  float dx = (X_MAX-X_MIN)/numSteps;
  float x = X_MIN;
  for(int i = 0; i < numSteps; ++i) {
    drawLineSegment(x, f.value(x), x+dx, f.value(x+dx));
    x += dx;
  }
}

void drawLineSegment(float x0, float y0, float x1, float y1) {
  pushMatrix();
  line(mapX(x0), mapY(y0), mapX(x1), mapY(y1));
  popMatrix();
}

void drawLine(float x0, float y0, float x1, float y1) {
  pushMatrix();
  line(mapX(x0), mapY(y0), mapX(x1), mapY(y1));
  popMatrix();
}

void drawTitle(String title) {
  fill(0);
  textSize(TEXT_SIZE);
  text(title, (width - textWidth(title)) * 0.5, TEXT_SIZE);
}

float mapX(float x) {
  return (x - X_MIN)/(X_MAX - X_MIN) * width;
}

float mapY(float y) {
  return (Y_MAX - y) /(Y_MAX - Y_MIN) * height;
}

float mapLength(float d) {
  return d / (X_MAX - X_MIN) * width;
}
