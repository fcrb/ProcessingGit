import processing.pdf.*;
float sideLength;
//Good values: (PI/4, 0.17), (PI/3, 0.3), (PI/6, 0.06), (PI/5, 0.15)
float levelFraction = 0.21;
float rotationAngle = PI /3;
boolean alternateUpDown = false;

void setup() {
  size(800, 600);//, PDF, "tesselationKoch5.pdf");
  background(255 );
  strokeWeight(0.072 );

  float sideInCM = 8;
  sideLength = 72 * sideInCM / 2.54; 
  translate(sideLength *0.1, sideLength * 0.4);

  drawParallelogram1by2();
  //  drawParallelogramTromineoe();
}  

void drawSide() {
  //  drawKochSide();
  //  drawArcSide();
  //  drawSineWaveSide();
drawPuzzleSide();
//  drawDampedSineWaveSide();
}

void drawArcSide() {
  //arc from 0,0 to sideLength, 0
  float radius = sideLength *0.54;
  float arcInRadians = 2 * asin(sideLength / 2 / radius);
  arc(sideLength/2, radius * cos(arcInRadians/2), radius * 2, radius * 2, (3 * PI - arcInRadians) /2, (3 * PI + arcInRadians) /2);
}

void drawPuzzleSide() {
  //arc from 0,0 to sideLength, 0
  float r = sideLength *0.15;
  float d = 2 * r;
  float theta = PI /4;
  float x0 = sideLength/2 - 2 * r * cos(theta);
  line(0, 0, x0, 0);
  arc(x0, -r, d, d, -theta, PI/2);
  float yc = -r - 2 * r * sin(theta);
  arc(sideLength/2, yc, d, d, PI - theta, 2 * PI + theta);
  float x1 = sideLength - x0;
  arc(x1, -r, d, d, PI/2, PI+theta);
  line(x1, 0, sideLength, 0);
}

void drawSineWaveSide() {
  int numSegments = 30;
  float dx = sideLength / numSegments;
  float amp = sideLength * 0.2;
  float cycles = 1.5;
  float prevY = 0, nextY = 0;
  for (int i = 0; i < numSegments; ++i) {
    nextY = amp * sin((i+1) * cycles * PI * 2.0 / numSegments);
    line(i * dx, prevY, (i + 1) * dx, nextY);
    prevY = nextY;
  }
}

void drawDampedSineWaveSide() {
  int numSegments = 100;
  float dx = sideLength / numSegments/2;
  float amp = sideLength * 0.2;
  float cycles = 120;
  float prevY = 0, nextY = 0;
  for (int i = 0; i < numSegments; ++i) {
    nextY = amp * sin( cycles * PI * 2.0 / (i+1)) * (i+1) / numSegments;
    float x0 = i * dx;
    float x1 = (i+1) * dx;
    line(x0, prevY, x1, nextY);
    line(sideLength - x0, prevY, sideLength - x1, nextY);
    prevY = nextY;
  }
}


void drawParallelogram1by1() {
  drawSide();
  translate(sideLength, 0);
  rotate(PI/3);
  drawSideFlipped();
  translate(sideLength, 0);
  rotate(2 * PI/3);
  drawSide();
  translate(sideLength, 0);
  rotate(PI/3);
  drawSideFlipped();
}

void drawRect1by2() {
  drawSide();
  translate(sideLength, 0);
  drawSideFlipped();
  translate(sideLength, 0);
  rotate(PI/2);
  drawSide();
  translate(sideLength, 0);
  rotate(PI/2);
  drawSideFlipped();
  translate(sideLength, 0);
  drawSide();
  translate(sideLength, 0);
  rotate(PI/2);
  drawSideFlipped();
}

void drawSquare1by1() {
  drawSide();
  translate(sideLength, 0);
  rotate(PI/2);
  drawSideFlipped();
  translate(sideLength, 0);
  rotate(PI/2);
  drawSide();
  translate(sideLength, 0);
  rotate(PI/2);
  drawSideFlipped();
}

void drawParallelogram1by2() {
  drawSide();
  translate(sideLength, 0);
  drawSideFlipped();
  translate(sideLength, 0);
  rotate(PI/3);
  drawSide();
  translate(sideLength, 0);
  rotate(2 * PI/3);
  drawSideFlipped();
  translate(sideLength, 0);
  drawSide();
  translate(sideLength, 0);
  rotate(PI/3);
  drawSideFlipped();
}

void drawParallelogramTromineoe() {
  drawSide();
  translate(sideLength, 0);
  drawSideFlipped();
  translate(sideLength, 0);
  rotate(PI/3);
  drawSide();
  translate(sideLength, 0);
  drawSideFlipped();
  translate(sideLength, 0);
  rotate(2 * PI/3);
  drawSide();
  translate(sideLength, 0);
  rotate(PI/3);
  drawSideFlipped();
  translate(sideLength, 0);
  rotate(-PI/3);
  drawSide();
  translate(sideLength, 0);
  rotate(PI/3);
  drawSideFlipped();
}

void drawSideFlipped() {
  pushMatrix();
  translate(sideLength, 0);
  rotate(PI);
  drawSide();
  popMatrix();
}

//Available methods to call in drawSide()
//Should start at (0,0) and finish at (sideLength,0)

void drawKochSide() {
  drawKoch(sideLength);
}

void drawKoch(float thisSideLength) {
  if (thisSideLength < 2) {
    line(0, 0, thisSideLength, 0); 
    return;
  }

  float nextSideLength = levelFraction*thisSideLength;

  //first part
  pushMatrix();
  if (alternateUpDown) {
    translate(nextSideLength, 0);
    rotate(PI);
  }
  drawKoch(nextSideLength);
  popMatrix();

  //last part
  pushMatrix();
  if (alternateUpDown) {
    translate(thisSideLength, 0);
    rotate(PI);
  } 
  else {
    translate(thisSideLength - nextSideLength, 0);
  }
  drawKoch(nextSideLength);
  popMatrix();


  //middle part
  pushMatrix();
  translate(nextSideLength, 0);
  rotate( - rotationAngle);
  float newSideLength = (0.5 - levelFraction)*thisSideLength/cos(rotationAngle);
  drawKoch(newSideLength);
  translate(newSideLength, 0);
  rotate(2 * rotationAngle);
  drawKoch(newSideLength);
  popMatrix();
}
