int numCirclesPerCircle = 6;
float initialRadius;
int maxLevel = 3;
float scaleDown = 0.35;
boolean firstCircleDone = false;

void setup() {
  size(640, 640);

  translate(width/2, height/2);
  initialRadius = width / 4;
  background(255);
  noFill();
  drawCircleFractal(0, 0, initialRadius, 0);
}

void drawCircleFractal(float x, float y, float radius, int level) {
  if (level > maxLevel) {
    return;
  }
  if (level > 1) {
    strokeWeight(radius * 0.1);
    ellipse((float) x, (float)y, (float) radius * 2, (float) radius * 2);
  }

  float newRadius = radius  * scaleDown;
  for (int i = 0; i < numCirclesPerCircle; ++i) {
    float angle = i * 2 * PI / numCirclesPerCircle;
    drawCircleFractal(x + radius * cos(angle), 
    y - radius * sin(angle), 
    newRadius, 
    level + 1);
  }
}

