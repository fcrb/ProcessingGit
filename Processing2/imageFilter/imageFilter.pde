import processing.pdf.*;

String inputFileName = "GoThrones.png";
String outputFileName = "GoThrones_bw.png";
boolean invertBlackAndWhite = false;
int threshold = 127;

PGraphicsPDF pdf;

int WHITE = color(255, 0);
int BLACK = color(0);

void setup() {
  size(1582,1464);
  PImage img = loadImage(inputFileName);
  image(img, 0, 0);
  convertToBlackWhite();
//  addLabels("2013 IAA BMW i3 Honeycomb structure by youkeys - Flickr: DSC01710_DxO.","Licensed under Creative Commons Attribution 2.0 via Wikimedia Commons");
  save(outputFileName);
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

void convertToBlackWhite() {
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
void toGrey() {
  loadPixels();
  int i = 0;
  for (int pixel : pixels) {
    float bright = (red(pixel) + green(pixel) + blue(pixel)) / 3;
    if(bright < 20) bright = 0;
    pixels[i++] = color((int) bright);
  }
  updatePixels();
}
