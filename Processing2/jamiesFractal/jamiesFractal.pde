float a0 = 1, b0 = 0.5, sizeScale = 0.05, a = 0, b = 0, totalRotation = 0;
float  bPrevious;

void setup() {
  size(1280, 960);
  background(255);
  a = a0 * sizeScale * width;
  b = b0 * sizeScale * height;
  bPrevious = b;
}

void draw() {
  drawRectsFilled();
}

void drawRects() {
  translate(width/2, height/2);
  scale(1, -1);
  rotate(totalRotation);
  rect(0, 0, a, b);
  totalRotation += atan(b/a);
  bPrevious = b;
  float newA = dist(0, 0, a, b);
  b = a * b / newA;
  a = newA;
}

void drawRectsNoFill() {
  noFill();
  stroke(0, 100);
  drawRects();
}

void drawRectsFilled() {
  fill(0,0,200, 5);
 noStroke();
  drawRects();
}

void drawCornersConnected() {  //if (keyPressed) {
  translate(width/2, height/2);
  scale(1, -1);
  noFill();
  stroke(0, 100);
  rotate(totalRotation);
  line(a, 0, a, b);
  float newA = dist(0, 0, a, b);
  float s = b * b / newA;
  line(0, b, s, b);
  totalRotation += atan(b/a);
  bPrevious = b;
  b = a * b / newA;
  a = newA;
}
