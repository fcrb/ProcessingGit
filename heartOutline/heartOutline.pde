import processing.pdf.*; //<>//

void setup() {
  int w = 72 * 12;
  int h = (int) (w * 0.875);
  size(w, h, PDF, "heartOutline.pdf");

  drawHeart();
}

void drawHeart() {
  float outerWidthMultiple = 0.287;
  noFill();
  rectMode(CENTER);
  background(255);
  float radius = width * outerWidthMultiple;
  float diameter = radius * 2;  
  translate(width / 2, width * 0.495);
  strokeWeight(0.072);
  float xCenter = -radius / sqrt(2);
  arc(xCenter, xCenter, diameter, diameter, 3 * PI /4, 7 * PI / 4);
  arc(-xCenter, xCenter, diameter, diameter, 5 * PI /4, 9 * PI / 4);
  line(2 * xCenter, xCenter + radius / sqrt(2), 0, xCenter + diameter );
  line(0, xCenter + diameter, -2 * xCenter, xCenter + radius / sqrt(2) );
}
