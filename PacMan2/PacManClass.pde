class PacMan {
  float x = width/2;
  float y = height/2;

  void draw() {
    arc(x, y, 80, 80, 0, PI+QUARTER_PI, PIE);
  }
}
