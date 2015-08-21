ArrayList<Point> points;
boolean mouseHasMoved = false;

class Point {
  float x, y;

  Point(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void ease(float easing, Point otherPoint) {
    x += easing * (otherPoint.x - x);
    y += easing * (otherPoint.y - y);
  }
}

void setup() {
  size(320, 320);
}

void draw() {
  background(0);
  noStroke();
  if (!mouseHasMoved) {
    if (pmouseX == mouseX)
      return;
    else {
      points = new ArrayList<Point>();
      int numberOfPoints = 500;
      for (int i = 0; i < numberOfPoints; ++i) {
        points.add(new Point(mouseX, mouseY));
      }
      mouseHasMoved = true;
    }
  }
  points.remove(0);
  points.add(new Point(mouseX, mouseY));
  int index = 0;
  for (Point point : points) {
    float zeroToOne =  ((float) index) / points.size();
    if (index < points.size() - 1) {
      float easing = 0.5; //0.005 + 0.01 * zeroToOne;
      point.ease(easing, points.get(index + 1));
    }
    fill(255 * zeroToOne, 0, 255 * (1-zeroToOne), zeroToOne * 200);
    float radius = 1.0 + zeroToOne * 30;
    ellipse(point.x, point.y, radius, radius);
    ++index;
  }
}

