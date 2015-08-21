int linesPerQuadrant = 50;
int numCopies = 1;
boolean finished = false;
void setup() {
  size(860, 860);
  background(255);
}

void draw() {
  drawSlow();
//  save("flower.png");
}

void drawSlow() {
  if (frameCount > linesPerQuadrant * numCopies * 4) {
    return;
  }
  translate(width/2, height/2);
  drawLine(frameCount);
}


void drawFast() {
  if (finished) return;

  background(255);
  for (int fc = 0; fc < linesPerQuadrant * numCopies * 4; ++fc) {
    pushMatrix();
    translate(width/2, height/2);
    drawLine(fc);
    popMatrix();
  }
  finished = true;
}

void drawLine(int fc) {
    strokeWeight(0.5);
    stroke(0, 25);
    int numRotations = fc / linesPerQuadrant;
    rotate ( -PI/(numCopies * 2) * numRotations);
    float x, y;
    x = y = 0;
    float w = width * 0.48;
    float toOrigin = w * (fc % linesPerQuadrant)/ (float) linesPerQuadrant;
    y = - toOrigin;
    x = w + y;
    line(x, 0, 0, y);
}
