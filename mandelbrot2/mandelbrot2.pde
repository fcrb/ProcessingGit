int[][] iterationCount;
//float xLeft=-2.2, xRight=0.8;
float xLeft=-.35, xRight=0.35;
int maxIterationCount = 512;

void setup() {
  size(1024, 1024);
  background(0);
  updateSet();
}

void updateSet() {
  iterationCount = new int[width][height];
  float xIncrement = (xRight - xLeft) / width;
  float yBottom = -xIncrement * height * 1.9 ;
  for (int i = 0; i < width; ++i) {
    for (int j = 0; j < height; ++j) {
      int count = 0;
      Complex c = new Complex(xLeft + xIncrement * i, yBottom + xIncrement * j);
      Complex z = c.copy();
      while (count++ < maxIterationCount) {
        z = z.times(z).times(z).plus(c);
        if (z.lengthSquared() > 20) break;
      } 
      iterationCount[i][j] = count;
    }
  }

  float maxHue = 2000;
  colorMode(HSB, maxHue, 100, 100);
float cValueMax = cValue(maxIterationCount);
  loadPixels();
  for (int i = 0; i < width; ++i) {
    for (int j = 0; j < height; ++j) {
      int count = iterationCount[i][j];
      if (count >= maxIterationCount)
        pixels[j * width + i ] = 0;
      else {
        int cValue =(int) (cValue(count) * maxHue / cValueMax);
        pixels[j * width + i ] = color(  cValue, 100, 100);
      }
    }
  }
  updatePixels();
}

float cValue(int count) {
  return pow(count, 0.1);
}

