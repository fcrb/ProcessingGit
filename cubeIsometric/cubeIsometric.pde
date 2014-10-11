int w, h, d;

void setup() {
  size(480, 480);
  background(255);
  int cubeEdgeLength = 3;
  w = cubeEdgeLength ;
  h = cubeEdgeLength + 2; 
  d = cubeEdgeLength + 1;

  //lower left face
  float xStep = width / w / 3;
  float yStep = xStep;
//  float zStep = xStep;
  float yBottom = height * 0.8;
  float y = yBottom;
  for (int i = 0; i < h; ++i) {
    float x = width / 12;
    for (int j = 0; j < w; ++j) {
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
  float ySlantStep = yStep * 0.4;
  for (int i = 0; i < d; ++i) {
    float x = width / 12 + i * xShift;
    for (int j = 0; j < w; ++j) {
      beginShape();
      vertex(x, y);
      vertex(x + xStep, y);
      vertex(x + xStep + xShift, y - ySlantStep);
      vertex(x + xShift, y - ySlantStep);
      vertex(x, y);
      endShape(CLOSE);
      x += xStep;
    }
    y -= ySlantStep;
  }

  //lower right  face
  xShift = xStep * 0.6;
  for (int i = 0; i < h; ++i) {
    float x = width / 12 + w * xStep;
      y = yBottom - i * yStep;

    for (int j = 0; j < d; ++j) {
      beginShape();
      vertex(x, y);
      vertex(x + xShift, y - ySlantStep);
      vertex(x + xShift, y - ySlantStep - yStep);
      vertex(x, y - yStep);
      vertex(x, y);
      endShape(CLOSE);
      x += xShift;
      y -= ySlantStep;
    }
  }
}
