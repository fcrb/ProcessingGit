class GumBall {
  float x;
  float y;
  float r;

  GumBall(float x_, float y_, float r_) {
    x=x_;
    y=y_;
    r=r_;
  }

  void draw() {
    fill(255, 150, 255);
    ellipse(x, y, r, r);
  }
}
