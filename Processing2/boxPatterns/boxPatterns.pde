import processing.pdf.*;
/*
The idea here is to create a library for quickly 
 creating crease patterns. Assume a unit square, with corners at 
 origin and (1,1)
 */

float inset;
float paperWidth;
float dashLength;
float strWeight = 72.0 / 300;
float inchesPerUnit = 1;

void setup() {
  size(792, 612);//, PDF, "boxPattern.pdf");
  paperWidth = 10.5 * 72;
  inset = (width - paperWidth) * 0.5;
  dashLength = paperWidth * 0.03;

  background(255);
  strokeWeight(strWeight);
  translate(inset, inset);
  translate( 0, height/2);

  rhomboidCube();

  markSpot();
}

void rhomboidCube() {
  turnLeft(30);
  pushMatrix();
  drawLine(5);
  popMatrix();

  pushMatrix();
  turnRight(120);
  drawLine(2);
  turnLeft(120); 
  drawLine(3);
  move(-2);
  turnLeft(60);
  drawLine(2);
  popMatrix();
  
  pushMatrix();
  move(3);
  pushMatrix();
  turnLeft(60);
  move(1);
  pushMatrix();
  turnRight(60);
  drawLine(2);
  turnRight(120);
  drawLine(1);
  popMatrix();
  turnRight(180);
  drawLine(4);
  move(-1);
  turnLeft(60);
  drawLine(5);
  popMatrix();
  turnRight(60);
  drawLine(4);
}

void rhomboidCube2() {
  turnLeft(30);
  drawLine(1);
  pushMatrix();
  turnRight(120);
  drawLine(2);
  popMatrix();
  drawLine(2);
  pushMatrix();
  drawLine(2);
  popMatrix();
  pushMatrix();
  turnRight(120);
  drawLine(2);
  popMatrix();
  turnLeft(60);
  drawLine(1);
  turnRight(60);
  drawLine(2);
  turnRight(120);
  drawLine(1);
  turnLeft(60);
  drawLine(3);
  pushMatrix();
  move(1);
  turnRight(120);
  drawLine(2);
  turnRight(60);
  drawLine(2);
  popMatrix();

  turnLeft(60);
  drawLine(1);
  turnRight(120);
  drawLine(3);
  turnLeft(60);
  drawLine(1);
  turnRight(120);
  drawLine(2);
  turnRight(60);
  drawLine(1);
  turnRight(60);
  pushMatrix();
  turnRight(60);
  drawLine(2);
  popMatrix();
  drawLine(3);
  pushMatrix();
  turnRight(60);
  drawLine(1);
  popMatrix();
  move(-1);
  turnRight(60);
  drawLine(2);
}

void markSpot() {
  fill(0);
  ellipse(0, 0, 10, 10);
}

void turnLeft(float degreesCCW) {
  turn(-degreesCCW);
}

void turnRight(float degreesCCW) {
  turn(degreesCCW);
}

void turn(float degreesCCW) {
  rotate(degreesCCW / 180 * PI);
}

void drawLine(float len) {
  float xDistance = len * inchesPerUnit * 72;
  line(0, 0, xDistance, 0);
  translate(xDistance, 0);
}

void move(float len) {
  float xDistance = len * inchesPerUnit * 72;
  translate(xDistance, 0);
}

void fold(float x0, float y0, float x1, float y1) {
  float numDashes = dist(x0, y0, x1, y1) * paperWidth / dashLength;
  float x = x0;
  float y = 1 - y0;
  float xStep = (x1 - x0) / numDashes / 2;
  float yStep = -(y1 - y0) / numDashes / 2;
  for (int i = 0; i < numDashes; ++i) {
    float xStop, yStop;
    if (i < numDashes - 1) {
      xStop = (x + xStep);
      yStop = (y + yStep);
    } 
    else {
      xStop = x1;
      yStop = 1- y1;
    }
    line(x* paperWidth, y * paperWidth, xStop * paperWidth, yStop * paperWidth);
    x += xStep * 2;
    y += yStep * 2;
  }
}

void cut(float x0, float y0, float x1, float y1) {
  line(x0 * paperWidth, (1-y0)*paperWidth, x1*paperWidth, paperWidth*(1-y1));
}
