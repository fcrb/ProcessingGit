float[] oldX, oldY;
int numberOfPoints;

void setup() {
  size(640, 480);
  numberOfPoints = 50;
  oldX = new float[numberOfPoints];
  oldY = new float[numberOfPoints];
}

void draw() {
  background(0);
  noStroke();
  // index will be from 0 to numberOfPoints - 1
  int index = frameCount % numberOfPoints;
  for (int i = 0 ; i < numberOfPoints; i++) {
    index = (frameCount + i) % numberOfPoints;
    float zeroToOne = ((float)index / numberOfPoints);
    float easing = 0.02 + 0.1 * zeroToOne;
    oldX[index] +=  easing *  (mouseX - oldX[index]);
    oldY[index] +=  easing *  (mouseY - oldY[index]);
    float radius = 10.0 + zeroToOne * 20;
    fill(255 * zeroToOne,0,255 * (1-zeroToOne), zeroToOne * 256);
    ellipse(oldX[index], oldY[index], radius, radius);
  }
}

