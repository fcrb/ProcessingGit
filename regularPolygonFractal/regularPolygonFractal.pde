int numVertices = 6;
float initialRadius;
int maxLevel = 5;
float scaleDown = 0.35;
boolean redraw = true;

interface JavaScript {
  void showValues(int numVertices, int maxLevel, float scale);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(640, 640);
}

void draw() {
  if (!redraw)
    return;
  redraw = false;
  if (javascript!=null) 
    javascript.showValues(numVertices, maxLevel, scaleDown);
  noStroke();
  translate(width/2, height/2);
  if (numVertices % 2 == 1)
    rotate(-PI/2);
  else
    rotate(PI/numVertices);
  initialRadius = width *0.3;
  background(255);
  //noFill();
  drawFractal(0, 0, initialRadius, 0);
}

void drawFractal(float x, float y, float radius, int level) {
  if (level > maxLevel) {
    return;
  }
  float c = 255.0 * (float) level /maxLevel;
  fill(255, 255 - c, 0); 
  polygon(x, y, radius, numVertices);
  float newRadius = radius  * scaleDown;
  for (int i = 0; i < numVertices; ++i) {
    float angle = i * 2 * PI / numVertices;
    drawFractal(x + radius * cos(angle), 
    y - radius * sin(angle), 
    newRadius, 
    level + 1);
  }
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void setNumberOfVertices(int n) {
  numVertices = n;
  redraw = true;
}

void setRecursionDepth(int n) {
  maxLevel = n;
  redraw = true;
}

void setScaleFactor(float s) {
  scaleDown = s;
  redraw = true;
}

