import processing.pdf.*;
float sideLengthInCm = 1;
float verticalSpace = sideLengthInCm * sqrt(3) / 2 / 2.54 * 72;
void setup() {
  size(576, 756, PDF, "graphPaperTriangular_1cm.pdf");
  background(255);

  stroke(192);
  strokeWeight(72.0/300);
  //quick hack, hacking the line lengths
  float y = 0;
  while (y < height) {
    line(0, y, width, y);
    y += verticalSpace;
  }

  rotate(PI/3);
  y = -height;
  while (y < height) {
    line(0, y, width*5, y);
    y += verticalSpace;
  }

  rotate(PI/3);
  y = -height - verticalSpace * 50;
  while (y < height) {
    line(-width, y, width, y);
    y += verticalSpace;
  }
}
