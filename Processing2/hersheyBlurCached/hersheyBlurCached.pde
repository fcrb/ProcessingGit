/* The comment immediately below is required for this
to work in a browser. See http://processingjs.org/articles/p5QuickStart.html#thingstoknowusingpjs*/
/* @pjs preload="hershey.png"; */
int numBlursCached = 25;
PImage[] images;
PImage originalImage;

void setup() {
  originalImage = loadImage("hershey.png");
  size(originalImage.width, originalImage.height);
  images = new PImage[numBlursCached];
 // originalImage.width
}

void draw() {
  // Because BLUR is a slow filter, I chose to cache the BLUR results
  // This is a nice demonstration of the effect of caching, since the
  // sketch's blurring becomes smoother as you move the mouse over
  // and populate the cache.

  // When modifying pixels, always call loadPixels() first, and
  // call updatePixels() when you are done modifying.

  int blurAmount = (int) (numBlursCached * mouseX / width);
  if (images[blurAmount] == null ) {
    image(originalImage, 0, 0, originalImage.width, originalImage.height);
    loadPixels();
    filter(BLUR, blurAmount);
    images[blurAmount] = get();
    updatePixels();
  } 
  else
    set(0, 0, images[blurAmount]);
}

void copyPixelsFromTo(color[] from, color[] to) {
  for (int i = 0; i < from.length; ++i)
    to[i] = from[i];
}

