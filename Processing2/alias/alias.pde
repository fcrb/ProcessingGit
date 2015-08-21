int blockSideInPixels;
int WHITE = color(255);
int BLACK = color(0);

void setup() {
  size(400, 400);
}

void draw() {
  background(255);

  drawBallBehindGlass();
  //  drawExampleText();

  alias();
}

void drawBallBehindGlass() {
  float time = millis() * 0.0002;
  float tCycle = min(time - floor(time), ceil(time)-time);
  blockSideInPixels = (int) (1 + tCycle * 40);
  if (blockSideInPixels < 1) {
    blockSideInPixels = 1;
  }

  fill(0);
  float sizeScalar = 1/(tCycle + 0.5);
  sizeScalar *= sizeScalar  * 0.2;
  ellipse(mouseX, mouseY, width * sizeScalar, height * sizeScalar);
}

void drawExampleEllipse() {
  strokeWeight(width/5);
  ellipse(mouseX, mouseY, width * 0.5, height * 0.5);
}
void drawExampleText() {
  float txtSize = 24;
  textSize(txtSize);
  String message = "FlexTech";
  txtSize *= width / textWidth(message) * 0.9;
  textSize(txtSize);
  fill(0);
  text(message, (width - textWidth(message)) / 2, (height + txtSize)/2);
}

void alias() {
  loadPixels();
  for (int y0 = 0; y0 + blockSideInPixels < height; y0 += blockSideInPixels) {
    for (int x0 = 0; x0 + blockSideInPixels< width; x0 += blockSideInPixels) {
      int gray = blockGrayLevel(x0, y0);
      setBlockColor(x0, y0, color(gray));
    }
  }
  updatePixels();
}

int  blockGrayLevel(int x0, int y0) {
  float graySum = 0;
  int pixelCount = 0;
  for (int y = y0; y < min (y0 + blockSideInPixels, height); ++y) {
    for (int x = x0; x < min (x0 + blockSideInPixels, width); ++x) {
      int pixelColor = pixels[x+y*width];
      graySum += (red(pixelColor)+green(pixelColor)+blue(pixelColor)) / 3;
      ++pixelCount;
    }
  }
  return (int) (graySum/pixelCount);
}

void  setBlockColor(int x0, int y0, color clr) {
  for (int y = y0; y < min (y0 + blockSideInPixels, height); ++y) {
    for (int x = x0; x < min (x0 + blockSideInPixels, width); ++x) {
      pixels[x+y*width] = clr;
    }
  }
}
