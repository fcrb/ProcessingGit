class Ball {
  float x, y;
  float diameter;
  float vx, vy;
  float startTime;
  boolean stopped = false;
  //  float elapsedSeconds;

  Ball() {
    x = xLeft;
    y = yBottom;
    diameter = width * 0.01;
    vx = speed;
    vy = -speed;
    //    elapsedSeconds = 0;
  }

  void move() {
    if (stopped) return;
    x += vx;
    y += vy;
    boolean switchX = (x > xRight && vx > 0) || (x < xLeft && vx < 0);
    boolean switchY = (y > yBottom && vy > 0) || (y < yTop && vy < 0);
    if (switchX && switchY) {
      //stop bouncing
      if (x > xRight) x = xRight;
      if (x < xLeft ) x = xLeft;
      if (y < yTop) y = yTop;
      if (y > yBottom) y = yBottom;
      vx = vy = 0;
      stopped = true;
      return;
    }

    if (switchX) {
      if (x > xRight && vx > 0) {
        x = xRight - (x - xRight);
      } 
      else {
        x = xLeft + (xLeft - x);
      }
      vx = -vx;
    }

    if (switchY) {
      if (y > yBottom && vy > 0) {
        y = yBottom - (y - yBottom);
      } 
      else {
        y = yTop + (yTop - y);
      }
      vy = -vy;
    }
  }

  void draw() {
    move();
    pushMatrix();
    fill(255, 0, 0);
    ellipse(x, y, diameter, diameter);
    popMatrix();
  }
}

