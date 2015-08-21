import processing.pdf.*;
float sideLength;
//Good values: (PI/4, 0.17), (PI/3, 0.3), (PI/6, 0.06), (PI/5, 0.15)
float levelFraction, rotationAngle;
boolean alternateUpDown = false;

void setup() {
  size(960, 480);//, PDF, "koch.pdf");
}

void draw() {
  background(255 );
  strokeWeight(0.072 );

  levelFraction = map(sin(frameCount * 0.03), -1, 1, 0.15, 0.25);
  rotationAngle = PI * levelFraction * 1.2;
  sideLength = width * 0.98;
  translate(sideLength *0.01, sideLength * 0.35);

  drawKoch(sideLength);
}

void drawKoch(float thisSideLength) {
  if (thisSideLength < 0.5) {
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
