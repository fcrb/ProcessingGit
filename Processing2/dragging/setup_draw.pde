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