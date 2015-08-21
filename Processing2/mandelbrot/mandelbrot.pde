int[][] iterationCount;
//float xLeft=-2.2, xRight=0.8;
float xLeft=-1.5, xRight=-1.24;
int maxIterationCount = 256;

void setup() {
  size(1280, 1024);
  background(0);
  updateSet();
}

void updateSet() {
  iterationCount = new int[width][height];
  float xIncrement = (xRight - xLeft) / width;
  float yBottom = -xIncrement * height / 2;
  for (int i = 0; i < width; ++i) {
    for (int j = 0; j < height; ++j) {
      int count = 0;
      float cx = xLeft + xIncrement * i;
      float cy = yBottom + xIncrement * j;
      float zx = cx, zy = cy;
      float sized2 = 0;
      while (count++ < maxIterationCount) {
        float temp = zx*zx - zy*zy + cx;
        zy = 2 * zx * zy + cy;
        zx = temp;
        if ( zx*zx + zy*zy > 20) break;
      } 
      iterationCount[i][j] = count;
    }
  }

  loadPixels();
  for (int i = 0; i < width; ++i) {
    for (int j = 0; j < height; ++j) {
      int count = iterationCount[i][j];
      if (count >= maxIterationCount)
        pixels[j * width + i ] = 0;
      else {
        int cValue = (int) (pow(count, 0.25) * 64);
        pixels[j * width + i ] = color(  cValue, 0,255 - cValue);
      }
    }
  }
  updatePixels();
}

