import processing.pdf.*;
void setup() {
  size(640, 640, PDF, "linkedRings.pdf");
  background(255);
  noFill();

  translate(width/2, height/2);

  float diameter = width * 0.4;
  float center = width * 0.25;
  int numCircles = 36;
  strokeWeight(width * 0.01);

  for (int i = 0; i < numCircles; ++i ) {
    float angle = i * 2 * PI / numCircles;
    ellipse(center * cos(angle), center * sin(angle), diameter, diameter);
  }
}
