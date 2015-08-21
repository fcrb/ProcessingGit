import processing.pdf.*;
float s;

void setup() {
  size(864, 864, PDF, "blackWhiteTrianglesPDFCut.pdf");
  translate(width/2, height/2);
  background(255, 255);
  noFill();
  stroke(0);
  strokeWeight(0.01);

  s = width / 4;
  rotate(PI/4);

  float size = 100;
  drawGrid();

  //draw out hexagon
  float x = startX() + s /2;
  float y = -(4 *  sqrt(3)/4) * s;
  for (int i=0; i < 6; ++i) {
    line(x, y, x + s*2, y);
    rotate(PI/3);
  }
}

float startX() {
  return - (s * (1.5));
}

void drawGrid() {
  // rotate(- PI/4);
  float xStart = startX();
  float x, y;
  x = xStart;
  y = -(3 *  sqrt(3)/4) * s;
  //top row
  for (int i = 0; i < 5; ++i) {
    x += s * 0.5;
    drawTriangle(x, y, i % 2 == 1);
  }
  //second row
  y += s / 2 * sqrt(3);
  x = xStart - s /2;
  for (int i = 0; i < 7; ++i) {
    x += s * 0.5;
    drawTriangle(x, y, i % 2 == 1);
  }
  //third row
  y += s / 2 * sqrt(3);
  x = xStart - s /2;
  for (int i = 0; i < 7; ++i) {
    x += s * 0.5;
    drawTriangle(x, y, i % 2 == 0);
  }
  //last row
  y += s / 2 * sqrt(3);
  x = xStart;
  for (int i = 0; i < 5; ++i) {
    x += s * 0.5;
    drawTriangle(x, y, i % 2 == 0);
  }
}

void drawTriangle(float x, float y, boolean flip) {
  pushMatrix();
  translate(x, y);
  if (flip) {
    rotate(PI);
  }

  //  translate(0, s * sqrt(3) / 4 - s/(2 * sqrt(3)));

  //borders
  triangle(-s / 2, s * sqrt(3) / 4, 
  s / 2, s * sqrt(3) / 4, 
  0, -s * sqrt(3) / 4);
  popMatrix();
}

