import processing.pdf.*;
float verticalSpace = 72;
void setup() {
  size(576, 756, PDF, "graphPaperTriangular.pdf");
  background(255);

  stroke(225);
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
