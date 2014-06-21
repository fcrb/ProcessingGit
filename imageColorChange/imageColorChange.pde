// @pjs preload must be used to preload the image
/* @pjs preload="http://mrbenson.org/pde/imageColorChange/dog.png"; */
PImage img;

void setup() {
  size(466, 408);
  img = loadImage("dog.png");
}

void draw() {
  image(img, 0, 0, width, height);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color c = get(x, y);
      color newColor = color(255-red(c), 255-green(c), 255-blue(c));
      set(x, y, newColor);
    }
  }
}

