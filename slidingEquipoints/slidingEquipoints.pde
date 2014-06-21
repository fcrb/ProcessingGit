int linesPerQuadrant = 20;
int numCopies = 3;
void setup() {
  size(640, 640);
  background(255);
  strokeWeight(0.5);
}

void draw() {
  if (frameCount > linesPerQuadrant * numCopies * 4) {
    return;
  }
  translate(width/2, height/2);
  
  int numRotations =frameCount / linesPerQuadrant;
  rotate ( -PI/(numCopies * 2) * numRotations);
  float x, y;
  x = y = 0;
  float w = width * 0.45;
  float toOrigin = w * (frameCount % linesPerQuadrant)/ (float) linesPerQuadrant;
  y = - toOrigin;
  x = w + y;
  line(x, 0, 0, y);
}
