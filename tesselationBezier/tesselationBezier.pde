import processing.pdf.*;

ArrayList<ControlPoint> controlPoints;
float sideLength;
//Good values: (PI/4, 0.17), (PI/3, 0.3), (PI/6, 0.06), (PI/5, 0.15)
float levelFraction = 0.21;
float rotationAngle = PI /3;
boolean alternateUpDown = false;
float sideInCM = 8;
float xOffset, yOffset;
float sw = 3;

void setup() {
  size(800, 600);//, PDF, "tesselationKoch5.pdf");

  sideLength = 72 * sideInCM / 2.54; 
  xOffset = sideLength *0.2;
  yOffset = sideLength *0.6;
  setupControlPoints();
}  

void draw() {
  background(255 );

  translate(xOffset, yOffset);

  for (int i = 1; i < controlPoints.size() - 1; ++i) {
    controlPoints.get(i).displayPoint();
  }
  drawParallelogram1by2();

//  drawParallelogramTromineoe();
//  println("mouseX, mouseY = " + mouseX + ","+mouseY);
}

void drawSide() {
  ArrayList<ControlPoint> cp = controlPoints;
  noFill();
  stroke(0, 0, 255);
  strokeWeight(sw);
  bezier(cp.get(0).x, cp.get(0).y, cp.get(1).x, cp.get(1).y, 
  cp.get(2).x, cp.get(2).y, cp.get(3).x, cp.get(3).y); 

  //  for (ControlPoint point : controlPoints) {
  //    point.displayLine();
  //  }

  //  for (ControlPoint point : controlPoints) {
  //    point.displayPoint();
  //  }
  //  for(int i = 1; i < controlPoints.size() - 1; ++i) {
  //        controlPoints.get(i).displayPoint();
  //  }
}

void setupControlPoints() {
  controlPoints = new ArrayList<ControlPoint>();
  ControlPoint nextControlPoint 
    = new ControlPoint(sideLength, 0, null);
  controlPoints.add(nextControlPoint);
  nextControlPoint 
    = new ControlPoint(sideLength * 2/3, -sideLength * 1/4, nextControlPoint);
  controlPoints.add(nextControlPoint);
  nextControlPoint 
    = new ControlPoint(sideLength * 1/3, 0, nextControlPoint);
  controlPoints.add(nextControlPoint);
  nextControlPoint 
    = new ControlPoint(0, 0, nextControlPoint);
  controlPoints.add(nextControlPoint);
}


void mousePressed() {
  for (ControlPoint point : controlPoints) {
    if (point.dragIfSelected())
      return;
  }
}  

void mouseReleased() {
  for (ControlPoint point : controlPoints) {
    point.releaseDrag();
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
