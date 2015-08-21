String fileName = "foreverUpArrowMove10";
String inputFileName = "pngIn/"+fileName+".png";
String outputFileName = "pngOut/"+fileName + ".png";

int WHITE = color(255, 0);
int BLACK = color(0);

void setup() {
  size(988, 616);
  PImage img = loadImage(inputFileName);
  image(img, 0, 0);
//  convertColor(color(246, 246, 246), WHITE);
//  convertColor(color(230, 230, 232), WHITE);
  convertColor(color(218, 218, 218), WHITE);
  save(outputFileName);
}

void convertColor(int from, int to) {
  loadPixels();
  int i = 0;
  for (int pixel : pixels) {
    if (colorDistance(from, pixel) < 15) {
      pixels[i] = to;
    }
    ++i;
  }
  updatePixels();
}

float colorDistance(int c1, int c2) {
  float sum = 0;
  float d = red(c1) - red(c2);
  sum += d*d;
  d = green(c1) - green(c2);
  sum += d*d;
  d = blue(c1) - blue(c2);
  sum += d*d;
  return sqrt(sum);
}
