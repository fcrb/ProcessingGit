class Ball {
  float diameter = 20;
  float strokeWidth = 3;
  float x, y;
  float vx, vy;
  float ay;

  Ball() {
    x = 0;
    y = 0;
    vx = 2;
    vy = 0;
    ay = 1;
  }

  void draw() {
    stroke(strokeWidth);
    ellipse(x, y, diameter, diameter);
    x += vx;//x moves forward with velocity vx
    vy += ay;//vy increases due to gravitational acceleration
    y += vy;//y moves forward with velocity vy
  }
}
