import processing.dxf.*;

int numRects = 27;

void setup() { 
  size(640, 640, P2D);
  background(255);

  beginRaw(DXF, "output.dxf");

  translate(width/2, height/2);
  float inset = 10;
  float lineWeight = 1;//0.001 inches (to indicate hairline);
  strokeWeight(lineWeight );
  rectMode(CENTER);
  noFill();
  stroke(0);
  for (int i = 0; i < numRects; ++i) {
    rect(0, 0, width * 0.9, width * 0.05);
    rotate(2 * PI / numRects);
  }
  endRaw();
}
