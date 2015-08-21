class Food {
  float diameter = 10;
  float x=random(width), y=random(height);

  Food() {
  }

  void draw() {
    ellipse(0, 0, diameter, diameter);
  }
}
