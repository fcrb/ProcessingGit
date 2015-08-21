class Hermit {
  float x = width/2, y = height/2;
  float radius = width/20;
  color c = color(255, 0, 0);
  boolean drag = false;

  void dragIfSelected() {
    drag  = (dist(x, y, mouseX, mouseY)<radius);
  }

  void drawIt() {
    fill(c);
    noStroke();
    ellipse(x, y, radius, radius);
  }

  void move() {
    if (drag) {
      x = mouseX;
      y = mouseY;
    }
  }

  void releaseDrag() {
    drag = false;
  }
}

