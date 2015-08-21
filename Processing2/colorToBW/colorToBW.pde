float brightnessThreshold = 120;

void setup() {
//  size(635, 1300);
  size(1957, 1013);
  PImage img;
  //  img =  loadImage("scott-kim-mirror-alphabet-inversion-or-ambigram.jpg");
  img =  loadImage("baconCode.jpg");
  image(img, 0, 0);
  loadPixels();
  //  toBlackWhite();
  toBlackWhite();
  updatePixels();
  save("cardsBW.jpg");
}

void toBlackWhite() {
  int i = 0;
  for (int pixel : pixels) {
    float lightness = (red(pixel) + green(pixel) + blue(pixel))/3;
    if (lightness < brightnessThreshold) {
      pixels[i] = 0;
    } 
    else { 
      pixels[i] = color(255);
    }
    ++i;
  }
}

void colorToGray() {
  int i = 0;
  for (int pixel : pixels) {
      pixels[i++] = color((int)((red(pixel) + green(pixel) + blue(pixel))/3));
  }
}

void greenToWhite() {
  int i = 0;
  for (int pixel : pixels) {
    float grn = green(pixel);
    if (abs(grn - 55) < 20 && blue(pixel) < 45) {
      pixels[i] = color(255);
    } 
    ++i;
  }
}
