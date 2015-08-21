class Point {
  float x, y;

  Point(float x_, float y_) { 
    x = x_;
    y = y_;
  }

  void invert(float scalar) {
    float c0 = 1/ dist(0, 0, x, y);
    c0 = c0 * c0 * scalar;
    x *= c0;
    y *= c0;
  }

  void invertAndRotate(float scalar) {
    float c0 = 1/ dist(0, 0, x, y);
    c0 = c0 * c0 * scalar;
    x *= c0;
    y *= c0;
    float angle = dist(0, 0, x, y) * 0.005;
    float xNew = x * cos(angle) - y * sin(angle);
    float yNew = x * sin(angle) + y * cos(angle);
    x = xNew;
    y=yNew;
  }

  Point midPoint(Point other) {
    return new Point((x + other.x)*0.5, (y + other.y)*0.5);
  }

  float distance() {
    return dist(0, 0, x, y);
  }


  void setDistStrokeWeight() {
    float d = distance();
    float sw = d * d * 0.00015;
    float minWeight = 0.1;
    if (sw < minWeight) {
      sw =  minWeight; 
      stroke(255, 0, 0);
    } 
    else stroke(0);
    strokeWeight(sw);
  }
}
