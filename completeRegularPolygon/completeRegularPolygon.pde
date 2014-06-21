int numVertices = 3;
float radius;
boolean rotate = false;
int lastTimeRotationTurnedOn = 0;
float rotationAngleAtLastTimeTurnedOff = 0;

void setup() {
  size(480, 480);
  radius = width * 0.48;

  background(255);
  fill(0);
  translate(width/2, height/2);
  float rotationAngle = rotate ? rotationAngleIfOn() : rotationAngleAtLastTimeTurnedOff;
  for (int i = 0; i < numVertices; ++i) {
    float angle1 = i * 2 * PI / numVertices + rotationAngle;
    float x1 = radius * cos(angle1);
    float y1 = radius * sin(angle1);
    for (int j = i+1; j < numVertices; ++j) {
      float colorScalar = min(j-i, numVertices - (j-i)) * 512.0 / numVertices;
      stroke( 255, colorScalar, 0);
      float angle2 = j * 2 * PI / numVertices + rotationAngle;
      float x2 = radius * cos(angle2);
      float y2 = radius * sin(angle2);
      line(x1, y1, x2, y2);
    }
  }
}

float rotationAngleIfOn() {
  return 0.0003 * (millis() - lastTimeRotationTurnedOn) + rotationAngleAtLastTimeTurnedOff;
}

void setNumberVertices(int n) {
  numVertices = n;
}

void toggleRotation() {
  if (rotate)
    rotationAngleAtLastTimeTurnedOff = rotationAngleIfOn();
  else lastTimeRotationTurnedOn = millis();
  rotate = !rotate;
}
