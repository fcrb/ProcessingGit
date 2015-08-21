int numCircles = 7;
float polygonSideLength;
void setup() {
  size(480, 480);
//  noLoop();
  polygonSideLength = width * 0.023;
}

void draw() {
  background(127);
  rectMode(CENTER);
  noFill();
  strokeWeight(2 );
  translate(width/2, height/2);
//  rotate(frameCount * 0.008);
  float radiusIncrement = width / 2 / (numCircles + 1);
  float angleDelta = -PI/18;
  for (int i = 3; i <= numCircles; ++i) {
    float radius = radiusIncrement * i;
    int numPolygons = i * 14;
    int rectColor = 60;
    for (int polyCtr = 0; polyCtr < numPolygons; ++polyCtr) {
      pushMatrix();
      float angle = polyCtr * 2 * PI / numPolygons;
      float x = radius * cos(angle);
      float y = radius * sin(angle);
      translate(x, y);
      rotate(angle - angleDelta);
      stroke(rectColor);
      rect(0, 0, polygonSideLength, polygonSideLength);
      popMatrix();
      rectColor = 255 - rectColor;
    }
    angleDelta = -angleDelta;
    radius += radiusIncrement;
  }
}
