class Ball {
  float x, y;
  float vy;
  
  Ball() {
    x = diameter /2;
    y = x;
    vy = 0;
  }
  
  void draw() {
    ellipse(x, y, diameter, diameter);
    x += vx;
    y += vy;
    vy += ay;
  }
  
  boolean offScreen() {
    return y + diameter /2 > height;
  }
  
}
