class Food {
  float x = random(0, width);
  float y = random(0, height);

  void draw() {
    ellipse(x, y, 80, 80);
  }
}
