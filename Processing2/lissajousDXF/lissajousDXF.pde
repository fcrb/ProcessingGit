import processing.dxf.*;

int frequency1 = 15;
int frequency2 = 13;

void setup() {
  size(640, 640, P2D);
  noLoop();
  stroke(0);

  background(255);
  translate(width/2, height/2);
  beginRaw(DXF, "output.dxf");

  int numSteps = 1000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 2 * PI / numSteps * i;
    x = width * .45 * cos(frequency1 * angle);
    y = height * .45 * cos(frequency2 * angle);
    if (i>0) {
      float sw = 8000 / (500 + dist(x, y, 0, 0) / width * 800)* width/400;
      strokeWeight(sw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  endRaw();
}
