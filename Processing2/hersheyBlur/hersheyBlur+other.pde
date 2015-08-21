int w = 733 / 2;
int h = 510 / 2;
PImage img;
int numBlursCached = 25;
color[][] clr = new color[numBlursCached][w*h];

void setup() {
  float scale = 0.5;
  size(w, h);
  img = loadImage("hershey.png");
}

//loadPixels();
//for (int i = 0; i < halfImage; i++) {
//  pixels[i+halfImage] = pixels[i];
//}
//updatePixels();

void draw() {
  tile(1);
  loadPixels();
  int blurAmount = numBlursCached * mouseX / width;
  if(clr[blurAmount][0] == 0) {
    filter(BLUR, blurAmount);
    copyPixelsFromTo(pixels, clr[blurAmount]);
  } else
    copyPixelsFromTo(clr[blurAmount], pixels);
  updatePixels();
}

void copyPixelsFromTo(color[] from, color[] to) {
  for(int i = 0; i < from.length; ++i)
    to[i] = from[i];
}

void varyColorSmoothlyByMousePosition() {
  tile(1);
  loadPixels();
  float f_x = (float) mouseX / (float) width;
  float f_y = (float) mouseY / (float) height;
  for (int i = 0; i < pixels.length; i++) {
    color c = pixels[i];
    color c1 = color(red(c) + f_x * (green(c) - red(c)), 
                      green(c) + f_x * (blue(c) - green(c)), 
                      blue(c) + f_x * (red(c) - blue(c)), alpha(c));
    color c2 = color(red(c1) + f_y * (blue(c1) - red(c1)), 
                      green(c1) + f_y * (red(c1) - green(c1)), 
                      blue(c1) + f_y * (green(c1) - blue(c1)), alpha(c1));
    pixels[i] = c2;
  }
  updatePixels();
}

void varyColorAbrubtlyByMousePosition() {
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = pixels[i] * (mouseX + 1) / (mouseY + 1);
  }
  updatePixels();
}

void tile(int numTilesAcross) {
  background(0);
  // image(img, 0, 0, mouseX*2, mouseY*2);
  int n = numTilesAcross;
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      image(img, i * width/n, j * height/n, width/n+1, height/n+1);
}

