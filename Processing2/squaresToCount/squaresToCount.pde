import processing.pdf.*;
int side = 2;
int dim = 100;

void setup() { 
  size(dim * side * 2 - side, dim * side * 2 - side , PDF, "10000squares.pdf");

  noStroke();
  fill(0);
  background(255);
  for (int i = 0; i < dim; ++i) {
    for (int j = 0; j < dim; ++j) {
      rect(i * 2 * side, j * 2 * side, side, side);
    }
  }
}
