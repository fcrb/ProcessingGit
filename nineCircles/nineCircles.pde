import processing.pdf.*;
void setup() {
  size(600, 600, PDF, "nineCircles.pdf");

  background(255);
  translate(width/2, height/2);
  drawNine();
}

void drawNine() {
  float d = width * 0.23;
  float r = d * 1.5;
  for (int i = 0; i < 9; ++i) {
    ellipse(r, 0, d, d);
    rotate(2 * PI / 9);
  }
}

void drawEleven() {
  float d = 115;
  float r = d * 1.8;
  for (int i = 0; i < 11; ++i) {
    ellipse(r, 0, d, d);
    rotate(2 * PI / 11);
  }
}
