import processing.pdf.*; //<>//

void setup() {
  int w = 72 * 12;
  int h = w;
  size(w, h, PDF, "shamrockOutline.pdf");

  drawShamrock();
}

void drawShamrock() {
  for (int i = 0; i < 4; ++i) {
    pushMatrix();
    translate(width / 2, width * 0.495);
    rotate(PI/2 * i);

    drawHeart(0.5);
    popMatrix();
  }
}

void drawHeart(float scalar) {
  float outerWidthMultiple = 0.287 * scalar;
  noFill();
  rectMode(CENTER);
  background(255);
  float radius = width * outerWidthMultiple;
  float diameter = radius * 2;  
  stroke(0);
  strokeWeight(0.072 * 100);
  float xCenter = -radius / sqrt(2);
  arc(xCenter, xCenter, diameter, diameter, 3 * PI /4, 7 * PI / 4);
  arc(-xCenter, xCenter, diameter, diameter, 5 * PI /4, 9 * PI / 4);
  line(2 * xCenter, xCenter + radius / sqrt(2), 0, xCenter + diameter );
  line(0, xCenter + diameter, -2 * xCenter, xCenter + radius / sqrt(2) );
}
