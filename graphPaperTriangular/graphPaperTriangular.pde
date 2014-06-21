import processing.pdf.*;
float verticalSpace = 72;
void setup() {
  size(576, 756, PDF, "graphPaperTriangular.pdf");
  background(255);

  stroke(225);
  //quick hack, hacking the line lengths
  float y = 0;
  while (y < height) {
    line(0, y, width, y);
    y += verticalSpace;
  }

  rotate(PI/3);
  y = -height;
  while (y < height) {
    line(0, y, width*2, y);
    y += verticalSpace;
  }

  rotate(PI/3);
  y = -height;
  while (y < height) {
    line(-width, y, width*2, y);
    y += verticalSpace;
  }
}
