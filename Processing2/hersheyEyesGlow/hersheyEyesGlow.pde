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
  //  if (mouseX > 0 && mouseX < width) {
  //    loadPixels();
  //    filter(BLUR, blurAmount);
  //    updatePixels();
  //  }
  loadPixels();
  float redFraction = map(sin(millis()*0.001), -1, 1, 0.2, 1);
  float greenFraction = map(sin(millis()*0.00174823745), -1, 1, 0.2, 1);
  float blueFraction = map(sin(millis()*0.00074823745), -1, 1, .2, 1);
  for (int i = 0; i < width*height; i++) {
    int p = pixels[i];
    pixels[i] = color(red(p) * redFraction, green(p) * greenFraction, blue(p) * blueFraction);
  }
  updatePixels();

  fill(255, 0, 0, map(sin(millis()*0.005), -1, 1, 0, 155));
  noStroke();
  //    print("(x,y)="+mouseX + ','+mouseY);
  float pupilSize = 18;
  ellipse(292, 206, pupilSize, pupilSize); 
  ellipse(445, 209, pupilSize, pupilSize);
}
