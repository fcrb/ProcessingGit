class PacMan {
  float x = gridify(width/2);
  float y = gridify(height/2);
  float diameter = 40;
  float rotation = 0;
  float stepSize = 1.5;

  void draw() {
    pushMatrix();
    translate(x, y);
    handleKeys();
    rotate(rotation);
    noStroke();
    fill(255,255,0);
    float angle = (1+ sin(millis() * 0.015))*PI/8;
    arc(0, 0, diameter, diameter, angle, 2 * PI - angle);
    popMatrix();
  }

  void handleKeys() {
    if (!keyPressed) {
      return;
    }
    if (key != CODED) {
      return;
    }
    if (keyCode == UP) {
      x = gridify(x);
      rotation = -PI/2;
      y -= stepSize;
    } 
    else if (keyCode == DOWN) {
      x = gridify(x);
      rotation = PI/2;
      y += stepSize;
    } 
    else if (keyCode == LEFT) {
      y = gridify(y);
      rotation = PI;
      x -= stepSize;
    } 
    else if (keyCode == RIGHT) {
       y = gridify(y);
     rotation = 0;
      x += stepSize;
    }
    float radius = diameter/2;
    if(x < -radius) x = width + radius;
    if(x > width + radius) x = - radius;
    if(y < -radius) y = height + radius;
    if(y > height + radius) y = - radius;
  }
}
