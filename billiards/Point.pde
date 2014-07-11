class Point {
  float x, y;

  Point(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void draw() {
    stroke(255,0,0);
    point(round(x), round(y));
  }
}

