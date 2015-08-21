int BLACK = color(0);

/* I tried other fonts, but rotate wasn't handled correctly. */

void setup() {
  size(800, 800);
  translate(width/2, height/2);
  background(255);
  fill(0);
  noSmooth();

  String name = "Freya";
  float txtSize = width / 2 / name.length();
  textSize(txtSize);
  //  textFont(font, txtSize);
  rotate(PI/6);
  for (int i = 0; i < 6; ++i) {
    float tiltAngle  = -PI /16;
    rotate(tiltAngle);
    text(name, width/6, width/8);
    rotate(PI/3 - tiltAngle);
  }

  //superimpose mirror image
  loadPixels();
  int[] mirroredPixels = new int[pixels.length];
  arrayCopy(pixels, mirroredPixels);
  for (int i = 0; i < pixels.length; i++) {
    if (pixels[i] == BLACK) {
      int row = i / width;
      int col = i % width;
      mirroredPixels[width * (row + 1) - (col + 1)] = BLACK;
      //      mirroredPixels[pixels.length - (i+1)] = BLACK;
    }
  }
  arrayCopy(mirroredPixels, pixels);
  updatePixels();
}
