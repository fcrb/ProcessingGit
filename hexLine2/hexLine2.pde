int penWidth = 10;
void setup() {
  size(320, 320);
}

void draw() {
  background(255);
  hexLine(width/2, height/2, mouseX, mouseY, penWidth);
}

void hexLine(float x0, float y0, float x1, float y1, float lineWidth) {
  noStroke();
  fill(0);
  strokeWeight(lineWidth);
  float endCapEdgeLength = lineWidth / sqrt(3);
  Vec2D v = new Vec2D(x1 - x0, y1-y0);
  beginShape();
  translate(x0, y0);
  vertex(0, 0);
  Vec2D vScaledToEndCapEdge = v.scaleToLength(endCapEdgeLength);
  Vec2D w = vScaledToEndCapEdge.rotateRadians(PI/3);
  vertex(w.x, w.y);
  w = v.plus(vScaledToEndCapEdge.rotateRadians(2 * PI/3)); 
  vertex(w.x, w.y);
  w = v;
  vertex(w.x, w.y);
  w = v.minus(vScaledToEndCapEdge.rotateRadians(PI/3)); 
  vertex(w.x, w.y);
   w = vScaledToEndCapEdge.rotateRadians(- PI/3);
  vertex(w.x, w.y);
  endShape(CLOSE);
}


void keyPressed() {
  char[] keyCodes = new char[] {
    '1', '2', '3', '4', '5', '6', '7', '8', '9'
  };
  for (int i = 0; i < keyCodes.length; ++i) {

    if (key == keyCodes[i]) {
      setPenWidth(5*(i+2));
    }
  }
}

void setPenWidth(int w) {
  penWidth = w;
}
