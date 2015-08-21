int blockSideInPixels = 20;
int WHITE = color(255);
int BLACK = color(0);

void setup() {
  size(400, 400);

  background(255);
  drawExampleEllipse();

//  alias();
}

void drawExampleEllipse() {
  strokeWeight(width/5);
  ellipse(width/2, height/2, width * 0.5, height * 0.5);
}

//void drawExampleText() {
//  float txtSize = 24;
//  textSize(txtSize);
//  String message = "FlexTech";
//  txtSize *= width / textWidth(message) * 0.9;
//  textSize(txtSize);
//  fill(0);
//  text(message, (width - textWidth(message)) / 2, (height + txtSize)/2);
//}

void alias() {
  for (int y0 = 0; y0 + blockSideInPixels < height; y0 += blockSideInPixels) {
    for (int x0 = 0; x0 + blockSideInPixels< width; x0 += blockSideInPixels) {
      int gray = blockGrayLevel(x0, y0);
      setBlockColor(x0, y0, color(gray));
    }
  }
}

int  blockGrayLevel(int x0, int y0) {
  float graySum = 0;
  int pixelCount = 0;
  for (int y = y0; y < min (y0 + blockSideInPixels, height); ++y) {
    for (int x = x0; x < min (x0 + blockSideInPixels, width); ++x) {
      int pixelColor = get(x, y);
      graySum += (red(pixelColor)+green(pixelColor)+blue(pixelColor)) / 3;
      ++pixelCount;
    }
  }
  return (int) (graySum/pixelCount);
}

void  setBlockColor(int x0, int y0, color clr) {
  for (int y = y0; y < min (y0 + blockSideInPixels, height); ++y) {
    for (int x = x0; x < min (x0 + blockSideInPixels, width); ++x) {
      set(x, y, clr);
    }
  }
}
