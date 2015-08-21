// @pjs preload must be used to preload the image
/* @pjs preload="http://mrbenson.org/docs/img/hershey.png"; */
PImage img;
int numBlurlevels = 25;
int previousBlurAmount = -1;

void setup() {
  size(733, 510);
//  img = loadImage("http://mrbenson.org/docs/img/hershey.png");
  img = loadImage("hershey.png");
}

void draw() {
  int blurAmount = numBlurlevels * mouseX / width;
  if (blurAmount == previousBlurAmount)
    return;
  image(img, 0, 0, 733, 510);
  // When modifying pixels, always call loadPixels() first, and
  // call updatePixels() when you are done modifying.
  if (mouseX > 0 && mouseX < width) {
    loadPixels();
    filter(BLUR, blurAmount);
    updatePixels();
  }
}

