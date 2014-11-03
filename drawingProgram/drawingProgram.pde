boolean mouseIsBeingDragged = false;

void setup() {
  size(320, 240);
  background(255);
  PImage img = loadImage("colorWheel.png" );
  image(img, 0, 0);
}

void draw() {
  if (mouseIsBeingDragged) {
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  loadPixels();
  int pxl = pixels[width * mouseY + mouseX];
  println("red="+red(pxl)+ "+ green="+ green(pxl)+ "+ blue="+ blue(pxl));
}

void mouseDragged() {
  mouseIsBeingDragged = true;
}

void mouseMoved() {
  mouseIsBeingDragged = false;
}
