class Hermit {
  float x = width/2, y = height/2;
  float diameter = width/10;
  color c = color(255, 0, 0);
  boolean drag = false;

  void dragIfSelected() {
    drag  = (dist(x, y, mouseX, mouseY) < diameter * 0.5);
  }

  void drawIt() {
    fill(c);
    noStroke();
    if (drag) {
      x = mouseX;
      y = mouseY;
    }
    ellipse(x, y, diameter, diameter);
  }

  void releaseDrag() {
    drag = false;
  }
}

Hermit hermit;

void draw() {
  background(0);
  hermit.drawIt();
}

void mousePressed() {
  hermit.dragIfSelected();
}  

void mouseReleased() {
  hermit.releaseDrag();
}  

void setup() {
  size(320, 240);
  hermit = new Hermit();
}


