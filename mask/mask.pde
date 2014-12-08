PImage maskImage;
int[] maskArray;
int WHITE = color(255);
int BLACK = color(0);

void setup() {
  size(800, 800);

  drawDemoMask();
  maskArray = copyScreenPixels();
}

void draw() {
  background(255, 255, 100);

  noStroke();
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, width/4, height/4);
  maskPixels(maskArray);
}

void drawDemoMask() {
  background(0);
  fill(255);
  noSmooth();
  noStroke();
  for (int i = 0; i < 50; ++i) {
    ellipse(random(width), random(height), width/10, height/10);
  }
}

void maskPixels(int[] maskPixels) {
  loadPixels();
  for (int i = 0; i < pixels.length;++i) {
    int mPxl = maskPixels[i];
    if (mPxl != WHITE) {
      //      if (mPxl ==  BLACK) {
      pixels[i] = mPxl;
      //      } 
      //      else {
      //        int p = pixels[i];
      //        pixels[i] = color(red(p) * mPxl / 255, green(p) * mPxl / 255, blue(p) * mPxl / 255);
      //      }
    }
  }
  updatePixels();
}

int[] copyScreenPixels() {
  loadPixels();
  int[] pixelsCopy = new int[pixels.length];
  for (int i = 0; i < pixels.length;++i) {
    //    int p = pixels[i];
    //    pixelsCopy[i] = color((red(p) + green(p) + blue(p))/3);
    pixelsCopy[i] = pixels[i];
  }
  return pixelsCopy;
}
