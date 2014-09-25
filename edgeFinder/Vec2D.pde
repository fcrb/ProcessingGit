class Vec2D {
  float x, y;

  Vec2D(float x_, float y_) {
    x = x_;
    y=y_;
  }
  
  float length() {
    return dist(x, y, 0, 0);
  }
  
  float innerProduct(Vec2D other) {
    return x* other.x + y * other.y;
  }
}

