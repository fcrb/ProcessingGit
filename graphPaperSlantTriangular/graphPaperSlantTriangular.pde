import processing.pdf.*;
float sideLengthInCm = 1;
float verticalSpace = sideLengthInCm / 2.54 * 72;
void setup() {
  size(576, 756, PDF, "graphPaperSlantTriangular_1cm.pdf");
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
  
  //slant lines
  
  rotate(PI/4);
  float yStep = verticalSpace / sqrt(2);
  y = -( (int) (height / yStep)) * yStep;
  while (y < height) {
    line(0, y, width*5, y);
    y += yStep;
  }
  
  rotate(PI/2);
  y = -( (int) (height / yStep)) * yStep * 2;
  while (y < height*2) {
    line(-width , y, width, y);
    y += yStep;
  }

}
