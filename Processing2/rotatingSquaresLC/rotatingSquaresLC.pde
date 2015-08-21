import processing.pdf.*;

int n = 24;
float theta = PI / (2*n);

void setup() {
  size(12 * 72, 6 * 72, PDF, "pdf/rotatingSquares_"+(2*n)+".pdf");

  background(255);
  strokeWeight(0.072);
  rectMode(CENTER);
  noFill();
  translate(width/4, height/2);
  float s = width / 2 * 0.98;
  drawSquares(s);
  s = nextS(s);
  translate(width / 2 - s / n /2, -s/n/2);
  drawSquares(s);
}

void drawSquares(float s) {
  stroke(0, 0, 255);
  for (int i = 0; i < n; ++i) {
    stroke(255, 0, 0);
    rect(0, 0, s, s);
    rotate(theta);
    s = nextS(s);
    stroke(0, 0, 255);
    rect(0, 0, s, s);
    rotate(-theta);
    s = nextS(s);
  }
}

float nextS(float s) {
  float tanTheta = tan(theta);
  float r = s * tanTheta / (1 + tanTheta);
  return dist(0, 0, s-r, r);
}
