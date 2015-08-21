
void setup() {
  size(625, 381);
  PImage img = loadImage("AllDenominations.jpg");
  image(img, 0, 0);
  loadPixels();
  int pixel = pixels[0];
  
  println("pixel="+pixel);
  println("red="+red(pixel)+" green="+green(pixel)+" blue="+blue(pixel));
  colorToGray();
  updatePixels();
//  save("AllDenominationsBW.jpg");
}

void messUpColors() {
  int i = 0;
  for (int pxl : pixels) {
      pixels[i++] = pxl * 3;
  }
}
void colorToGray() {
  int i = 0;
  for (int pxl : pixels) {
      pixels[i++] = color((int)((red(pxl) 
                    + green(pxl) + blue(pxl))/3));
  }
}
