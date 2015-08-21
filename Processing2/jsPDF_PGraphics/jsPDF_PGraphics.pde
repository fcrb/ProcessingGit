import processing.pdf.*;
PGraphics pg;

void setup() {
  size(320, 240);
  noLoop();
  beginRecord(PDF, "fooSingleFrame.pdf");
  drawSomething();
  endRecord();
}

void drawSomething() {
  background(255);
  strokeWeight(width/6);
  ellipse(width/2, height/2, width/2, height/2);
}
