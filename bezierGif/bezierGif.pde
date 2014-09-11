ArrayList<ControlPoint> controlPoints;
int numFrames = 120; 

void setup() {
  size(128, 128);
  background(255);
  controlPoints = new ArrayList<ControlPoint>();
  ControlPoint nextControlPoint 
    = new ControlPoint(null);
  controlPoints.add(nextControlPoint);
  for (int i = 0; i < 3; ++i ) {
    nextControlPoint = new ControlPoint(nextControlPoint);
    controlPoints.add(nextControlPoint);
  }
}

void draw() {
  if (frameCount > numFrames) return;
  background(255);

  ArrayList<ControlPoint> cp = controlPoints;
  noFill();
  stroke(0, 0, 255);
  strokeWeight(height/80.0);

  //move control points according to time
  ControlPoint cp0 = cp.get(0);
  ControlPoint cp1 = cp.get(1);
  ControlPoint cp2 = cp.get(2);
  ControlPoint cp3 = cp.get(3);

  //create a sequence that is periodic, completing one full cycle in numFrames frames
  float angleScalar = PI * (frameCount - 1) / numFrames;
  float w = width * 0.4;
  float h = height * 0.4;
  float x0 = width/2;
  float y0 = height/2;
  cp0.moveTo(x0 + w * sin(2 * angleScalar), y0 + h * sin(4 * angleScalar));
  cp1.moveTo(x0 + w * sin(4 * angleScalar), y0 + h * sin(6 * angleScalar));
  cp2.moveTo(x0 + w * sin(6 * angleScalar), y0 + h * sin(8 * angleScalar));
  cp3.moveTo(x0 + w * sin(8 * angleScalar), y0 + h * sin(2 * angleScalar));

  bezier(cp0.x, cp0.y, cp1.x, cp1.y, cp2.x, cp2.y, cp3.x, cp3.y); 

  for (ControlPoint point : controlPoints) {
    point.displayPoint();
  }
  saveFrame("bezierGif-###.png");
}

class ControlPoint {
  float x, y;
  float diameter = 8;
  color c = color(255, 0, 0);
  boolean drag = false;
  ControlPoint next;

  ControlPoint(ControlPoint nextControlPoint) {
    next = nextControlPoint;
  }

  void displayLine() {
    //draw line between points
    if (next != null) {
      stroke(255, 0, 0, 100);
      strokeWeight(diameter * 0.2);
      line(x, y, next.x, next.y);
    }
  }

  void moveTo(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void displayPoint() {
    //draw anchor/control point
    stroke(0);
    strokeWeight(2);
    fill(255, 255, 0);
    ellipse(x, y, diameter, diameter);
  }
}

