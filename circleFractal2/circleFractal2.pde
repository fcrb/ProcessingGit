float initialRadius;
int maxLevel = 8;

void setup() {
  size(1440, 720);

  translate(width/2, height/2);
  initialRadius = width * 0.45;
  background(255);
  //  strokeWeight(2);
  noStroke();
  drawCircleFractal(-initialRadius, initialRadius, 0);
}

void drawCircleFractal(float xLeft, float xRight, int level) {
  if (level > maxLevel) {
    return;
  }
  float diameter = (xRight - xLeft) / 2;
  fill(level % 2 == 0?  128: 255);
  ellipse(xLeft * 0.75 + xRight * 0.25, 0, diameter, diameter);
  drawCircleFractal(xLeft, xLeft + diameter, level + 1);
  fill(level % 2 == 0?  128: 255);
  ellipse(xLeft * 0.25 + xRight * 0.75, 0, diameter, diameter);
  drawCircleFractal(xLeft + diameter, xRight, level + 1);
}

