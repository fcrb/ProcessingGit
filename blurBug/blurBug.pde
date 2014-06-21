int numBlurlevels = 20;
int previousBlurAmount = -1;

void setup() {
  size(320, 240);
}

void draw() {
  int blurAmount = numBlurlevels * mouseX / width;
  if (blurAmount == previousBlurAmount)
    return;
  background(0);
  ellipse(width/2, height/2, width, height );
  filter(BLUR, blurAmount);
  previousBlurAmount = blurAmount;
}

