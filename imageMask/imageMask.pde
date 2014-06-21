// @pjs preload must be used to preload the image
/* @pjs preload="http://mrbenson.org/docs/img/hershey.png"; */
PImage img;
int numBlurlevels = 25;

void setup() {
  size(733, 510);
  //  img = loadImage("http://mrbenson.org/docs/img/hershey.png");
  img = loadImage("imageMaskExample.png");
}

void draw() {
  image(img, 0, 0, width, height);
  // When modifying pixels, always call loadPixels() first, and
  // call updatePixels() when you are done modifying.
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; j < height; y++) {
      color currentColor = get(x, y);
      color newColor = color(blue(currentColor), red(currentColor), green(currentColor));
      set(x, y, newColor);
    }
  }
  updatePixels();
}
