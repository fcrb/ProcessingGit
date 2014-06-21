float massLeft = 1;
float armLengthLeft = 1;
float massRight = 1;
float MIN_MASS = 1;
float MAX_MASS = 10;
float MIN_LENGTH = 1;
float MAX_LENGTH = 10;
boolean parametersChanged = true;

//adjust right mass, or adjust right arm length to balance?
boolean autoAdjustRightMassToBalance = false;

interface JavaScript {
  void showValues(float massR, float lengthL);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(640, 160);
  background(0);
  reset();
}

void draw() {
  background(0);
  noStroke();
  float fulcrumHeightFrac = 0.2;
  translate(width/2, height /2);
  //draw fulcrum
  float fulcrumSide = height * fulcrumHeightFrac * 2 / sqrt(3) * scale();
  float fulcrumHeight = height * fulcrumHeightFrac * scale();
  fill(200);
  triangle(0, 0, - fulcrumSide /2, fulcrumHeight
    , fulcrumSide /2, fulcrumHeight);

  //draw arm
  strokeWeight(3 * scale());
  float xLeft = -unscaledLeftLengthInPixels() * scale();
  float xRight = unscaledRightLengthInPixels()  * scale();
  stroke(255);
  line(xLeft, 0, xRight, 0);
  noStroke();
  float leftDiameter = 10 * pow(massLeft, 1.0/3)  * scale();
  float rightDiameter = 10 * pow(massRight, 1.0/3) * scale();
  //draw left mass
  fill(255, 0, 0);
  ellipse(xLeft, 0, leftDiameter, leftDiameter);
  fill(0);
  ellipse(xLeft, 0, 3, 3);

  //draw right mass
  fill(255);
  ellipse(xRight, 0, rightDiameter, rightDiameter);
  fill(0);
  ellipse(xRight, 0, 3, 3);

  if (javascript!=null && parametersChanged) {
    javascript.showValues(massLeft, armLengthLeft, massRight, armLengthRight());
    parametersChanged = false;
  }
}

void reset() {
  massLeft = 5;
  massRight = 5;
  armLengthLeft = 5;
  parametersChanged = true;
}

float armLengthRight() {
  return massLeft * armLengthLeft / massRight;
}

float unscaledLeftLengthInPixels() {
  return width * 0.45 * armLengthLeft / MAX_LENGTH;
}

float unscaledRightLengthInPixels() {
  return width * 0.45 * armLengthRight() / MAX_LENGTH;
}

float scale() {
  float maxLength = max(unscaledLeftLengthInPixels(), unscaledRightLengthInPixels());
  if (maxLength <= width * 0.45)
    return 1;
  return width * 0.45 / maxLength;
}

void balanceMass(boolean useMass) {
  autoAdjustRightMassToBalance = useMass;
}

void setLeftMass(float m) {
  if (autoAdjustRightMassToBalance) {
    massRight *= m / massLeft;
  }
  massLeft = m;
  parametersChanged = true;
}

void setLeftArmLength(float len) {
  if (autoAdjustRightMassToBalance) {
    massRight *= len / armLengthLeft;
  }
  armLengthLeft = len;
  parametersChanged = true;
}
