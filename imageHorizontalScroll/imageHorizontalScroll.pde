// @pjs preload must be used to preload the image
/* @pjs preload="http://mrbenson.org/pde/imageHorizontalScroll/dog.png"; */
PImage img;
int[] movingPixels;
boolean movingPixelsLoaded = false;

void setup() {
  size(466, 408);
  movingPixels = new int[width * height];
  img = loadImage("dog.png");
}

void draw() {
  if (!movingPixelsLoaded) {
    image(img, 0, 0, width, height);
    loadPixels();
    copyPixels(pixels, movingPixels);
    updatePixels();
    movingPixelsLoaded = true;
  }
  shiftPixelsLeft();
}

void shiftPixelsLeft() {
  int[] firstColumn = new int[height];
  //store leftmost column of movingPixels
  for (int y = 0; y < height; y++) {
    firstColumn[y] = movingPixels[y * width];
  }
  //shift everyone one pixel to the left
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {
      movingPixels[y * width + x - 1] = movingPixels[y * width + x];
    }
  }
  for (int y = 0; y < height; y++) {
    movingPixels[(y+1) * width - 1] = firstColumn[y];
  }
  loadPixels();
  copyPixels(movingPixels, pixels);
  updatePixels();
}

void copyPixels(int[] from, int[] to) {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      to[y * width + x] = from[y * width + x];
    }
  }
}

