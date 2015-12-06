
/* TODO:
 Fix bug with amplitudeMultipler below.
 Create PDF capability.
 */

int n1 = 7;
int n2 = 4;
float gearSpeed = 0.003;
float axleSeparation;
int numIterationsPerGear = 100;

float amplitudeMultipler = 0.03;//try n1=n2=1, and ampMulti =0.236, 0.237, then 0.238 with
//  return height * 0.2 * (1 + amplitudeMultipler * (cos(theta * n1) +  sin(theta * n1 * 2 )+   cos(theta * n1 * 3 )+   sin(theta * n1 * 5 )));

void setup() {
  size(960, 720);

  calibrateAxleSeparation();
}


float radius(float theta) {
  //return height * 0.1 * (1 + 0.3 * (cos(theta * n1) + cos(theta * n1 * 2)));
  //return height * 0.2 * (1 + 0.1 * (cos(theta * n1) + 2 * cos(theta * n1 * 2)));
  return height * 0.2 * (1 + amplitudeMultipler * (cos(theta * n1) +  sin(theta * n1 * 2 )+   cos(theta * n1 * 3 )+   sin(theta * n1 * 5 )));
  //return height * 0.1 * (1 + 0.8 * cos(theta * n1) ); 
  //return height * 0.1 * (1 + 0.7 * sin(theta * n1) );
}

void calibrateAxleSeparation() {
  float gearOneAngle = 2 * PI;
  float maxSeparation = 5000;
  float minSeparation = 0;
  while (maxSeparation - minSeparation > 0.0001) {
    axleSeparation = (maxSeparation + minSeparation) * 0.5;
    if (gearTwoRotation(gearOneAngle) * n2 < gearOneAngle * n1) {
      maxSeparation = axleSeparation;
    } else {
      minSeparation = axleSeparation;
    }
  }
  println(axleSeparation);
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
  float angle = frameCount * gearSpeed;
  //angle = angle - 2 * PI * floor(angle / (2 * PI));
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
  pushMatrix();
  rotate(-gearOneRotation());
  line(0,0,radius(0),0);
  drawAxle();  
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
  pushMatrix();
  rotate(gearTwoRotation(gearOneRotation()));
  float x = radius(0) - axleSeparation;
  line(0,0,x,0);
  drawAxle();
  float numStepsForSecondGear = numIterationsPerGear * 10;
  float dTheta = 2 * PI / n1 / numStepsForSecondGear;
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