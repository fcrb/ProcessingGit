import processing.pdf.*;

String inputFileName = "pullWeedInput.jpg";
String outputFileName = "pullWeedOutput.jpg";
boolean invertBlackAndWhite = false;

PGraphicsPDF pdf;

int WHITE = color(255, 0);
int BLACK = color(0);

void setup() {
  size(600, 210);
  PImage img = loadImage(inputFileName);
  if (img != null) {
    image(img, 0, 0);
    int threshold = 50;//typical value is 127
    convertToBlackWhite(threshold);
    //swapBlackWhite();
    //  addLabels("2013 IAA BMW i3 Honeycomb structure by youkeys - Flickr: DSC01710_DxO.","Licensed under Creative Commons Attribution 2.0 via Wikimedia Commons");
    save(outputFileName);
  }
}


void addLabels(String s1, String s2) {
  fill(255);
  float txtSize = 36;
  textSize(txtSize);
  text(s1, 0.5 * (width-textWidth(s1)), height - txtSize * 3);
  text(s2, 0.5 * (width-textWidth(s2)), height - txtSize);
}

void addLabel(String s) {
  fill(0);
  float txtSize = 18;
  textSize(txtSize);
  text(s, 0.5 * (width-textWidth(s)), height - txtSize);
}

void convertToBlackWhite(int threshold ) {
  loadPixels();
  int i = 0;
  for (int pixel : pixels) {
    float bright = (red(pixel) + green(pixel) + blue(pixel)) / 3;
    int strokeColor = invertBlackAndWhite ? (bright < threshold ? WHITE : BLACK)
      : (bright > threshold ? WHITE : BLACK);
    pixels[i++] = strokeColor;
  }
  updatePixels();
}

void swapBlackWhite() {
  loadPixels();
  int i = 0;
  for (int pixel : pixels) {
    pixels[i++] = (pixel == WHITE ? BLACK : WHITE);
  }
  updatePixels();
}


void toGrey() {
  loadPixels();
  int i = 0;
  for (int pixel : pixels) {
    float bright = (red(pixel) + green(pixel) + blue(pixel)) / 3;
    if (bright < 20) bright = 0;
    pixels[i++] = color((int) bright);
  }
  updatePixels();
}