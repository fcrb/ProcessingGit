PGraphics mask;
int WHITE = color(255);
int BLACK = color(0);

void setup() {
  size(640, 140);

  drawDemoMask();
}

void draw() {
  background(255, 255, 100);
  noStroke();
  fill(255, 0, 0);
  float diameter = height * 0.8;
  ellipse(mouseX, mouseY, diameter, diameter);
  maskPixels();
}

void drawDemoMask() {
  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.noSmooth();
  mask.noStroke();
  String msg = "hiding behind words...";
  float txtSize = 10;
  mask.textSize(txtSize);
  //scale text to fill width
  txtSize *= width / mask.textWidth(msg);
  mask.textSize(txtSize);
  mask.text(msg, (width - mask.textWidth(msg))*0.5, (height + txtSize)/2);
  mask.endDraw();
  mask.loadPixels();
}

void maskPixels() {
  loadPixels();
  int[] pxls = mask.pixels;
  for (int i = 0; i < pxls.length; ++i) {
    int maskPixel = pxls[i];
    if (maskPixel != WHITE) {
      pixels[i] = BLACK;
    }
  }
  updatePixels();
}
