float horizontalStretch = 1;

//index.html settings:
float penFractionOfWidth = 0.02;
int numPointsOuterRing = 4;
int numPointsInnerRing = 6;
float radiusInnerRing = 0.7;
boolean  redrawNeeded = true;

interface JavaScript {
  void showValues(float strokeWt, int nOuter, int nInner, float radius);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(600,600);
}

void setStrokeWeight(float s) {
  penFractionOfWidth = s;
  redrawNeeded = true;
}

void setNumberVerticesInnerRing(int n) {
  numPointsInnerRing = n;
  redrawNeeded = true;
}

void setNumberVerticesOuterRing(int n) {
  numPointsOuterRing = n;
  redrawNeeded = true;
}

void setRadiusInnerRing(float r) {
  radiusInnerRing = r;
  redrawNeeded = true;
}

void draw() {
  if (!redrawNeeded) return;
  redrawNeeded = false;
  if (javascript!=null) 
    javascript.showValues(penFractionOfWidth, numPointsOuterRing, numPointsInnerRing, radiusInnerRing);
  background(255);
  noSmooth();
  translate(width/2, height/2);
  rotate(PI/2);
  strokeWeight(penFractionOfWidth * width);

  Ring r1 = new Ring();
  r1.setPoints(numPointsOuterRing);
  r1.setRadiusAsFractionOfWidth(1);

  Ring r2 = new Ring();
  r2.setPoints(numPointsInnerRing);
  r2.setRadiusAsFractionOfWidth(radiusInnerRing);

  r1.connectToRing(r2);
}

class Ring {
  float radiusAsFractionOfWidth;
  int numPoints;
  float rotation = 0;

  void setRadiusAsFractionOfWidth(float r) {
    radiusAsFractionOfWidth = r;
  }

  void setPoints(int n) {
    numPoints = n;
  }

  void connectToRing(Ring ring) {
    for (int i = 0; i < numPoints; ++i) {
      Point p = pointAtIndex(i);
      for (int j = 0; j < ring.numPoints; ++j) {
        Point p2 = ring.pointAtIndex(j);
        p.connectToPoint(p2);
      }
    }
  }

  Point pointAtIndex(int j) {
    float radius =  width * radiusAsFractionOfWidth / 2 * 0.95;
    float angle = 2 * PI / numPoints * j + rotation;
    return new Point(radius * cos(angle), radius * sin(angle) * horizontalStretch);
  }
}

class Point {
  float x, y;

  Point(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void connectToPoint(Point p) {
    line(x, y, p.x, p.y);
  }
}
