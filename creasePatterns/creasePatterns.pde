import processing.pdf.*;
/*
The idea here is to create a library for quickly 
 creating crease patterns. Assume a unit square, with corners at 
 origin and (1,1)
 */

float inset;
float paperWidth;
float dashLength;
float strWeight = 72.0 / 300;

void setup() {
  size(480, 480);//, PDF, "creasePattern.pdf");
  paperWidth = 6 * 72;
  inset = (width - paperWidth) * 0.5;
  dashLength = paperWidth * 0.03;

  background(255);
  strokeWeight(strWeight);
  translate(inset, inset);

  masuBox();
}

void blintz() {
  paper();
  valley(0, 0.5, 1, 0.5);
  valley(0.5, 1, 0.5, 0);
  valley(0, 0.5, 0.5, 1);
  valley(0.5, 1, 1, 0.5);
  valley(1, 0.5, 0.5, 0);
  valley( 0.5, 0, 0, 0.5);
}

void masuBox() {
  blintz();
  mountain(0, 0.25, 0.25, 0);
  valley(0, 0.75, 0.75, 0);
  valley(0.25, 1, 1, 0.25);
  mountain(0.75, 1, 1, 0.75);

  valley(0, 0.25, 0.75, 1);
  mountain(0, 0.75, 0.25, 1);
  valley(0.25, 0, 1, 0.75);
  mountain(0.75, 0, 1, 0.25);

  universal(0, 0.5, 0.125, 0.625);
  universal(0, 0.5, 0.25, 0.5);
  universal(0, 0.25, 0.125, 0.375);

  universal(0.5, 0, 0.625, 0.125);
  universal(0.5, 0, 0.5, 0.25);
  universal(0.25, 0, 0.375, 0.125);

  universal(0.5, 1, 0.375, 0.875);
  universal(0.5, 1, 0.5, 0.75);
  universal(0.625, 0.875, 0.75, 1);

  universal(1, 0.5, 0.75, 0.5);
  universal(1, 0.5, 0.875, 0.375);
  universal(1, 0.75, 0.875, 0.625);
}

void cup() {
  paper();
  valley(0, 1, 1, 0);

  float s = 2 / (2 + sqrt(2));
  float s2 = s / sqrt(2);
  mountain(0, s2, s2, 0);

  mountain(0, s2, s2, 1-s2);
  valley(s2, 1-s2, s, 1);
  mountain(s, 1, 1, 1-s2);
  valley(1, 1-s2, 1-s2, s2);
  mountain(1-s2, s2, s2, 0);
}

void paper() {
  mountain(0, 0, 1, 0);
  mountain(0, 0, 0, 1);
  mountain(1, 0, 1, 1);
  mountain(0, 1, 1, 1);
}

void valley(float x0, float y0, float x1, float y1) {
  float numDashes = dist(x0, y0, x1, y1) * paperWidth / dashLength;
  float x = x0;
  float y = 1 - y0;
  float xStep = (x1 - x0) / numDashes / 2;
  float yStep = -(y1 - y0) / numDashes / 2;
  for (int i = 0; i < numDashes; ++i) {
    float xStop, yStop;
    if (i < numDashes - 1) {
      xStop = (x + xStep);
      yStop = (y + yStep);
    } 
    else {
      xStop = x1;
      yStop = 1- y1;
    }
    line(x* paperWidth, y * paperWidth, xStop * paperWidth, yStop * paperWidth);
    x += xStep * 2;
    y += yStep * 2;
  }
}

void mountain(float x0, float y0, float x1, float y1) {
  line(x0 * paperWidth, (1-y0)*paperWidth, x1*paperWidth, paperWidth*(1-y1));
}

void universal(float x0, float y0, float x1, float y1) {
  strokeWeight(strWeight * 2 );
  line(x0 * paperWidth, (1-y0)*paperWidth, x1*paperWidth, paperWidth*(1-y1));
  strokeWeight(strWeight);
}
