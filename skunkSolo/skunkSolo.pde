SkunkModel model;
boolean redraw = true;
PImage lockedImage;
PImage unlockedImage;

void setup() {
  size(640, 480);
  model = new SkunkModel("Skunk");
  lockedImage = loadImage("lock.png");
  unlockedImage = loadImage("lock_open.png");
}

void draw() {
  if (redraw) {
    background(200);
    for (SkunkLetter letter : model.getLetters()) {
      letter.draw();
    }
    redraw = false;
  }
}

void mouseReleased() {
  //background(50);
  redraw = true;
  if (model.isDone()) {
    model = new SkunkModel("Skunk");
  }
  else
    model.roll();
}  

