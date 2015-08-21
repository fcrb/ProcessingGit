void setup() {
  size(320, 320);
  background(255);
  hexLine(width/5, height/5, width * 0.3, height * 0.7, 80, color(0));
}

void hexLine(float x0, float y0, float x1, float y1, float lineWidth, int clr) {
  pushMatrix();
  stroke(clr);
  fill(clr);
  strokeWeight(lineWidth);
  strokeCap(SQUARE);
  line(x0, y0, x1, y1);
  strokeWeight(.1);
  drawTip(x0, y0, x1, y1, lineWidth);
  drawTip(x1, y1, x0, y0, lineWidth);
  popMatrix();
}

void drawTip(float x0, float y0, float x1, float y1, float lineWidth) {
  beginShape();
  float lineLength = dist(x0, y0, x1, y1);
  float triHeight = lineWidth * 0.5 / sqrt(3);
  // altitude of cap
  float xTipDelta = (x1-x0) * triHeight / lineLength;
  float yTipDelta = (y1-y0) * triHeight / lineLength;
  vertex(x0 - xTipDelta, y0 - yTipDelta);
  // base vertices
  float xDelta = lineWidth * 0.5 * (y1 - y0) / lineLength;
  float yDelta = lineWidth * 0.5 * (x1 - x0) / lineLength;
  float eps = 0;
  vertex(x0 - xDelta + eps*(x1 - x0), y0 + yDelta + eps*(y1 - y0));
  vertex(x0 + xDelta, y0 - yDelta);
  endShape(CLOSE);
}
