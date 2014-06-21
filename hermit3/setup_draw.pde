ArrayList<Hermit> hermits;
color bgColor = color(0);

void draw() {
  background(bgColor);
  for(Hermit hermit : hermits) {
    hermit.drawIt();
  }
}

void mouseDragged() {
  for(Hermit hermit : hermits) {
    hermit.move();
  }
}  

void mousePressed() {
  for(Hermit hermit : hermits) {
    hermit.dragIfSelected();
  }
}  

void mouseReleased() {
  for(Hermit hermit : hermits) {
    hermit.releaseDrag();
  }
}  

void setup() {
  size(640, 480);
  hermits = new ArrayList<Hermit>();
  hermits.add(new Hermit());
}


