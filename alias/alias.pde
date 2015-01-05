int blockSideInPixels = 20;

void setup() {
  size(400, 400);
  background(255);

  strokeWeight(width/5);
  ellipse(width/2, height/2, width * 0.75, height * 0.75);

  alias();
}

void alias() {
  for (int y = 0; y < height; y += blockSideInPixels) {
    for (int x = 0; x < width; x += blockSideInPixels) {
      int gray = grayValue(x, y);
    }
  }
}

int  grayValue(int x, int y) {
  return 100;
}

void  setGrayValue(int x0, int y0, int grayValue) {
  for (int y = y0; y < y + blockSideInPixels; ++y) {
    for (int x = x0; x < x + blockSideInPixels; ++x) {
      
    }
  }
}

