import processing.pdf.*;

float baseRadius;
int drawingsPerCycle = 60;
int lineColor = 0;
int bgColor = 255;

void setup() {
  size(320, 320, PDF, "inverseEuclideanPlane320.pdf");
  baseRadius = width / 4 * 0.95;

  background(bgColor);
  translate(width/2, height/2);
  noFill();
  stroke(lineColor);
//  strokeWeight(0.001);
//  ellipse(0,0, baseRadius*4, baseRadius * 4);
  strokeWeight(4);
  int numCircles = 60;
  float lineRadius = baseRadius * 2;
  line(0, lineRadius, 0, -lineRadius);
  line(lineRadius, 0, -lineRadius, 0);
  for (int i = numCircles - 1; i >= 0; --i) {
    float r = baseRadius / (i + 1);
    float d = r * 2;
    stroke(lineColor);
    ellipse(0, r, d, d);
    ellipse(0, -r, d, d);
    ellipse(r, 0, d, d);
    ellipse(-r, 0, d, d);
  }
}

  
