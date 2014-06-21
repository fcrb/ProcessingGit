class Intersection {
  float x, y;
  Circle c1, c2;
  Circle topCircle = null;

  Intersection(float x_, float y_, Circle c1_, Circle c2_) {
    x = x_; 
    y = y_; 
    c1 = c1_; 
    c2 = c2_;
  }

  void draw() {
    pushMatrix();
    if (c1 == topCircle) { 
      noFill();
    } 
    else {
      fill(0);
    }
    ellipse(x, y, 10, 10);
    popMatrix();
  }

  float angleFromCenter(Circle c) {
    return angleInRadians(c.x, c.y, x, y);
  }

  void setTopCircle(Circle c, boolean isTop) {
    if (isTop) {
      topCircle  = c;
    } 
    else {
      //c is not top
      topCircle = (c == c1) ? c2 : c1;
    }
  }

  boolean hasTopCircle() {
    return topCircle != null;
  }
}
