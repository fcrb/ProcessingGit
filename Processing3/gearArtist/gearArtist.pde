/* Try these:
radius(): height * 0.35 * (1 + 0.3 * cos(theta * n1));

radius(): height * 0.35 * (1 + 0.1 * (cos(theta * n1) + cos(theta * n1 * 2)));
6/4

radius(): height * 0.1 * (1 + 0.4 * (cos(theta * n1) + cos(theta * n1 * 2)));

return height * 0.2 * (1 + 0.3 * (cos(theta * n1) + cos(theta * n1 * 2)));
2/4
*/

int n1 = 2;
int n2 = 2;
float axleSeparation = 400;
int numIterationsPerGear = 100;

void setup() {
  size(960, 720);
  
  calibrateAxleSeparation();
}

void calibrateAxleSeparation() {
  float gearOneAngle = 2 * PI;
  while(gearTwoRotation(gearOneAngle) * n2 < gearOneAngle * n1){
    axleSeparation *= 0.9999;
  }
  while(gearTwoRotation(gearOneAngle) * n2 > gearOneAngle * n1){
    axleSeparation *= 1.0001;
  }
  println(axleSeparation);
}

float radius(float theta) {
  //return height * 0.1 * (1 + 0.3 * (cos(theta * n1) + cos(theta * n1 * 2)));
  //return height * 0.2 * (1 + 0.1 * (cos(theta * n1) + 2 * cos(theta * n1 * 2)));
  //return height * 0.2 * (1 + 0.6 * cos(theta * n1) + 0.01 * cos(theta * n1 * 60 ));
  return height * 0.2 * (1 + 0.6 * cos(theta * n1) );
}

void draw() {
  background(255);
  translate((width - axleSeparation) * 0.5, height * 0.5);
  scale(1, -1);
  stroke(127);
  drawFirstGear();
  stroke(0, 0, 255);
  translate(axleSeparation, 0);
  drawSecondGear();
}

float gearOneRotation() {
  float angle = frameCount * 0.01;
  angle = angle - 2 * PI * floor(angle / (2 * PI));
  return angle;
}

float gearTwoRotation(float gearOneAngle) {
  float numStepsForSecondGear = numIterationsPerGear * 5;
  float dTheta = 2 * PI / n1 / numStepsForSecondGear;
  float theta1 = 0;
  float theta2 = 0;
  while (theta1 < gearOneAngle) {
    theta1 += dTheta;
    float r1 = radius(theta1);
    float r2 = axleSeparation - r1;
    theta2 += dTheta * r1 / r2;
  }
  return theta2;
}

void drawFirstGear() {
  drawAxle();
  pushMatrix();
  rotate(gearOneRotation());
  float dTheta = 2 * PI / n1 / numIterationsPerGear;
  float x = radius(0);
  float y = 0;
  for (int i = 0; i < numIterationsPerGear * n1; ++i) {
    float theta = dTheta * (i + 1);
    float r = radius(theta);
    float newX = r * cos(theta);
    float newY = r * sin(theta);
    line(x, y, newX, newY);
    x = newX;
    y = newY;
  }
  popMatrix();
}

void drawAxle() {
  float axleDiameter = width * 0.01;
  ellipse(0, 0, axleDiameter, axleDiameter);
}

void drawSecondGear() {
  drawAxle();
  pushMatrix();
  rotate(-gearTwoRotation(gearOneRotation()));
  float numStepsForSecondGear = numIterationsPerGear * 10;
  float dTheta = 2 * PI / n1 / numStepsForSecondGear;
  float x = radius(0) - axleSeparation;
  float y = 0;
  float theta2 = 0;
  for (int i = 0; i < numStepsForSecondGear * n2; ++i) {
    float theta1 = dTheta * (i + 1);
    float r1 = radius(theta1);
    float r2 = axleSeparation - r1;
    theta2 += dTheta * r1 / r2;
    float newX = - r2 * cos(theta2);
    float newY = r2 * sin(theta2);
    line(x, y, newX, newY);
    x = newX;
    y = newY;
  }
  popMatrix();
}