int numBlurlevels = 20;
int previousBlurAmount = -1;

void setup() {
  size(320, 240);
}

void draw() {
  int blurAmount = numBlurlevels * mouseX / width;
  if (blurAmount == previousBlurAmount)
    return;
  fill(color(0, 0, 255)); //blue rectangle
  rect(0, 0, width * 2 / 3, height/2);
  fill(color(0, 255, 0));//green rectangle
  rect(0, height/2, width * 2 / 3, height);
  fill(color(255, 0, 0));//red rectangle
  rect(width * 2 / 3, 0, width, height);
  filter(BLUR, blurAmount);
  previousBlurAmount = blurAmount;
}

