int w, h, d;

void setup() {
  size(480, 480);
  background(255);
  int cubeEdgeLength = 5;
  w = cubeEdgeLength;
  h = cubeEdgeLength; 
  d = cubeEdgeLength;

  //lower left face
  float xStep = width / w / 3;
  float yStep = xStep;
  float zStep = xStep;

  float y = height * 0.8;
  for (int i = 0; i < w; ++i) {
    float x = width / 12;
    for (int j = 0; j < h; ++j) {
      beginShape();
      vertex(x, y);
      vertex(x + xStep, y);
      vertex(x + xStep, y - yStep);
      vertex(x, y - yStep);
      vertex(x, y);
      endShape(CLOSE);
      x += xStep;
    }
    y -= yStep;
  }

  //upper  face
  float xShift = xStep * 0.6;
  yStep *= 0.4;
  for (int i = 0; i < w; ++i) {
    float x = width / 12 + i * xShift;
    for (int j = 0; j < h; ++j) {
      beginShape();
      vertex(x, y);
      vertex(x + xStep, y);
      vertex(x + xStep + xShift, y - yStep);
      vertex(x + xShift, y - yStep);
      vertex(x, y);
      endShape(CLOSE);
      x += xStep;
    }
    y -= yStep;
  }

  //lower right  face
  float xShift = xStep * 0.6;
  yStep *= 0.4;
  for (int i = 0; i < w; ++i) {
    float x = width / 12 + w * xStep;
    for (int j = 0; j < h; ++j) {
      beginShape();
      vertex(x, y);
      vertex(x + xStep, y);
      vertex(x + xStep, y - yStep);
      vertex(x, y - yStep);
      vertex(x, y);
      endShape(CLOSE);
      x += xShift;
    }
    y -= yStep;
  }
}
