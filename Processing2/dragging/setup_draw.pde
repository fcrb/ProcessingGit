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

