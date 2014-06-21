void setup() {
  size(120,120);
  textSize(64);
  textAlign(CENTER);
  frameRate(10);
}

void draw() {
  background(0);
  //char c = (char) (frameCount % 52 + 65);
  char c = key;
  text(c, 60,80);
}
