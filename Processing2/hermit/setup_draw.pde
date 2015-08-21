ArrayList<Hermit> hermits;
color bgColor = color(130, 200, 140);

void setup() {
  size(640, 480);
  hermits = new ArrayList<Hermit>();
  hermits.add(new Hermit());
}

void draw() {
  background(bgColor);
  for(Hermit hermit : hermits) {
    hermit.drawIt();
  }
}

