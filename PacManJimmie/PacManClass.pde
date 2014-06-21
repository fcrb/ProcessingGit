class PacMan {
  float x = width/2;
  float y = height/2; 
  float stepSize = 1.5;

  void draw() {
    arc(x, y, 20, 20, PI/6, 2 * PI - PI/6);
    handleKeys();
  }

  void handleKeys() {
    if (!keyPressed) {
      return;
    }
    if (key != CODED) {
      return;
    }
    if (keyCode == UP) {
      y -= stepSize;
    } 
    else if (keyCode == DOWN) {
      y += stepSize;
    } 
    else if (keyCode == LEFT) {
      x -= stepSize;
    } 
    else if (keyCode == RIGHT) {
      x += stepSize;
    }
  }
}

