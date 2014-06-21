ArrayList<Point> points;

class Point {
  float x, y;

  Point(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  void ease(float easing) {
    x += easing * (mouseX - x);
    y += easing * (mouseY - y);
  }
}

void setup() {
  size(640, 480);
  points = new ArrayList<Point>();
  int numberOfPoints = 200;
  for (int i = 0; i < numberOfPoints; ++i) {
    points.add(new Point(0,0));
  }
}

void draw() {
  background(0);
  noStroke();
  points.remove(0);
  points.add(new Point(mouseX, mouseY));
  int index = 0;
  for (Point point : points) {
    float zeroToOne =  sqrt(((float) index) / points.size());
    float easing = 0.005 + 0.01 * zeroToOne;
    point.ease(easing);
    fill(255 * zeroToOne, 0, 255 * (1-zeroToOne), zeroToOne * 50);
    float radius = 5.0 + zeroToOne * zeroToOne * 30;
    ellipse(point.x, point.y, radius, radius);
    ++index;
  }
}

