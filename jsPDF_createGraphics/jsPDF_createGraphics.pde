import processing.pdf.*;

void setup() {
  size(320, 240);
  drawSomething();
}

void drawSomething() {
  PGraphics pdf = createGraphics(width, height, PDF, "foo.pdf");
  pdf.beginDraw();
  pdf.background(255);
  pdf.strokeWeight(width/6);
  pdf.ellipse(width/2, height/2, width/2, height/2);
  pdf.dispose();
  pdf.endDraw();
}
