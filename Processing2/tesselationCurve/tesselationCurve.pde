import processing.pdf.*;
float sideLength;

void setup() {
  size(300, 300, PDF, "tesselationCurve.pdf");
  background(255 );

  sideLength = width*0.3;
  translate(sideLength/2, sideLength/2);

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

void drawSide() {
  drawCentroidArcSide();
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
void drawCentroidArcSide() {
  float r = 2 * sideLength / sqrt(3);
  arc(sideLength/2, sideLength * sqrt(3)/6, r, r, 7*PI/6, 11*PI/6);
}

void drawCentroidArcSide2() {
  float r =  sideLength ;
  arc(sideLength/2, 0, r, r, PI, 2 * PI);
}

void drawJaggy() {
  float triHeight = sideLength * 0.4;
  line(0,0, sideLength/2, -triHeight);
  line(sideLength/2, -triHeight, sideLength, 0 );
}

void drawJaggy2() {
  float triHeight = sideLength * 0.4;
  line(0,0, sideLength/3, -triHeight);
  line(sideLength/3, -triHeight/2, sideLength, 0 );
}

void drawKochSide() {
  drawKoch(0,0, sideLength, 0);
}

void drawKoch(float x0, float y0, float x1, float y1) {
  float levelFraction = 0.25;
  line(x0, y0, x0+levelFraction*(x1-x0), y0 + levelFraction * (y1 - y0));
  line(3 * sideLength/4, 0, sideLength, 0);
  pushMatrix();
  translate(sideLength/4, 0);
  rotate(-PI/4);
}
