import processing.pdf.*;

float dotDiameter = 15;

void setup() {
  size(320, 320);

  for (int numDots = 2; numDots < 11; ++numDots) {
    drawDots(numDots, false);
    drawDots(numDots, true);
  }
}

void drawDots(int numDots, boolean connectDots) {
  beginRecord(PDF, "dots-"+numDots + (connectDots ? "-connected":"")+".pdf"); 
  background(255);
  translate(width/2, height/2);
  scale(1, -1);
  fill(0);
  float r = (width - dotDiameter) * 0.495;
  //draw dots
  for (int i = 0; i < numDots; ++i) {
    float angle = i * 2 * PI / numDots;
    ellipse(r * sin(angle), r * cos(angle), dotDiameter, dotDiameter);
  }

  //connect the dots
  if (connectDots) {
    strokeWeight(dotDiameter * 0.25);
    stroke(0);
    for (int i = 0; i < numDots; ++i) {
      for (int j = i + 1; j < numDots; ++j) {
        float angleI = i * 2 * PI / numDots;
        float angleJ = j * 2 * PI / numDots;
        line(r * sin(angleI), r * cos(angleI), r * sin(angleJ), r * cos(angleJ));
      }
    }
  }
  endRecord();
}
