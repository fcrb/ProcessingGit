ArrayList<ControlPoint> controlPoints;

void setup() {
  size(480, 240);
  background(255);
  controlPoints = new ArrayList<ControlPoint>();
  float cornerScale = 0.1;
  ControlPoint nextControlPoint 
    = new ControlPoint(width *  cornerScale, height * cornerScale, null);
  controlPoints.add(nextControlPoint);
  nextControlPoint 
    = new ControlPoint(width *  cornerScale, height * (1-cornerScale), nextControlPoint);
  controlPoints.add(nextControlPoint);
  nextControlPoint 
    = new ControlPoint(width * (1-cornerScale), height * cornerScale, nextControlPoint);
  controlPoints.add(nextControlPoint);
  nextControlPoint 
    = new ControlPoint(width *  (1-cornerScale), height * (1-cornerScale), nextControlPoint);
  controlPoints.add(nextControlPoint);
}

void draw() {
  fill(255, 127);
  noStroke();
  rect(0,0,width,height);

  ArrayList<ControlPoint> cp = controlPoints;
  noFill();
  stroke(0, 0, 255);
  strokeWeight(height/80.0);
  bezier(cp.get(0).x, cp.get(0).y, cp.get(1).x, cp.get(1).y, 
  cp.get(2).x, cp.get(2).y, cp.get(3).x, cp.get(3).y); 

  for (ControlPoint point : controlPoints) {
    point.displayLine();
  }

  for (ControlPoint point : controlPoints) {
    point.displayPoint();
  }
}

void mousePressed() {
  for (ControlPoint point : controlPoints) {
    if (point.dragIfSelected())
      return;
  }
}  

void mouseReleased() {
  for (ControlPoint point : controlPoints) {
    point.releaseDrag();
  }
}  

class ControlPoint {
  float x, y;
  float diameter = width/40;
  color c = color(255, 0, 0);
  boolean drag = false;
  ControlPoint next;

  ControlPoint(float x_, float y_, ControlPoint nextControlPoint) {
    next = nextControlPoint;
    x = x_; 
    y = y_;
  }

  boolean dragIfSelected() {
    drag  = (dist(x, y, mouseX, mouseY)<diameter);
    return drag;
  }

  void displayLine() {
    //draw line between points
    if (next != null) {
      stroke(255, 0, 0, 100);
      strokeWeight(diameter * 0.2);
      line(x, y, next.x, next.y);
    }
  }

  void displayPoint() {
    if (drag) {
      x = mouseX;
      y = mouseY;
    }
    //draw anchor/control point
    stroke(0);
    strokeWeight(2);
    fill(240);
    ellipse(x, y, diameter, diameter);
  }

  void releaseDrag() {
    drag = false;
  }
}

