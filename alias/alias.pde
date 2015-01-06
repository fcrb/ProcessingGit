int blockSideInPixels;
int WHITE = color(255);
int BLACK = color(0);

void setup() {
  size(400, 400);
}

void draw() {
  background(255);

  strokeWeight(width/5);
  ellipse(width/2, height/2, width * 0.75, height * 0.75);
  blockSideInPixels = mouseX;
  if (blockSideInPixels < 1) {
    blockSideInPixels = 1;
  }
  alias();
}

void alias() {
  for (int y0 = 0; y0 < height; y0 += blockSideInPixels) {
    for (int x0 = 0; x0 < width; x0 += blockSideInPixels) {
      int gray = blockGrayLevel(x0, y0);
      setBlockColor(x0, y0, gray >127 ? WHITE : BLACK);
    }
  }
}

int  blockGrayLevel(int x0, int y0) {
  float graySum = 0;
  int pixelCount = 0;
  for (int y = y0; y < y0 + blockSideInPixels; ++y) {
    for (int x = x0; x < x0 + blockSideInPixels; ++x) {
      int pixelColor = get(x, y);
      graySum += (red(pixelColor)+green(pixelColor)+blue(pixelColor)) / 3;
      ++pixelCount;
    }
  }
  return (int) (graySum/pixelCount);
}

void  setBlockColor(int x0, int y0, color clr) {
  for (int y = y0; y < y0 + blockSideInPixels; ++y) {
    for (int x = x0; x < x0 + blockSideInPixels; ++x) {
      set(x, y, clr);
    }
  }
}
