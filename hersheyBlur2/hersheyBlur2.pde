int numBlurlevels = 20;

void setup() {
  size(320, 240);
}

void draw() {
  ellipse(width/2, height/2, width , height );
  loadPixels();
  int blurAmount = numBlurlevels * mouseX / width;
  filter(BLUR, blurAmount);
  updatePixels();
}

