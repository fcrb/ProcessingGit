import processing.pdf.*;
float sideLengthInCm = 1;
float verticalSpace = sideLengthInCm / 2.54 * 72;
void setup() {
  size(576, 756, PDF, "graphPaperSquare_1cm.pdf");
  background(255);

  stroke(192);
  strokeWeight(72.0/300);
  float y = 0;
  while (y < height) {
    line(0, y, width, y);
    y += verticalSpace;
  }

  float x = 0;
  while (x < height) {
    line(x, 0, x, height);
    x += verticalSpace;
  }
}
