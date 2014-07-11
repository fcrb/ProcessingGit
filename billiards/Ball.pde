class Ball {
  float x, y;
  float diameter;
  float speed;
  float startTime;
  float elapsedSeconds;
  
  Ball() {
    x = xLeft;
    y = yBottom;
    diameter = width * 0.02;
    speed = 5;
    elapsedSeconds = 0;
  }
  
  void draw() {
    pushMatrix();
    fill(255,0,0);
    ellipse(x, y, diameter, diameter);
    popMatrix();
  }
  
}
