class PacMan {
  float x = width/2;
  float y = height/2;
  float diameter = 40;
  float rotation = 0;

  void draw() {
    pushMatrix();
    translate(x, y);
    handleKeys();
    rotate(rotation);
    noStroke();
    fill(255,255,0);
    float angle = (1+ sin(millis() * 0.01))*PI/8;
    arc(0, 0, diameter, diameter, angle, 2 * PI - angle, PIE);
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
      rotation = -PI/2;
      --y;
    } 
    else if (keyCode == DOWN) {
      rotation = PI/2;
      ++y;
    } 
    else if (keyCode == LEFT) {
      rotation = PI;
      --x;
    } 
    else if (keyCode == RIGHT) {
      rotation = 0;
      ++x;
    }
  }
}
