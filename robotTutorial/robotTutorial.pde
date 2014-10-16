float scale = 0.5;

void setup() {
  size(800, 600);
}

void draw() {
  background(255);

//draw a grid to help me draw my robot
  translate(width/2, height/2);
  pushMatrix();
  drawGrid(-width/2, -height/2, 20, 100, 12);
  drawMouseCoordinates(-width/2, -height/2, 9);
  popMatrix();
  
  //draw body of robot
  float bodyWidth = 100 * scale;
  float bodyHeight = 150 * scale;
  float yTopOfBody = -bodyHeight/2;
  rect(-bodyWidth/2, yTopOfBody, bodyWidth, bodyHeight);
  
  //draw neck of robot
  float neckWidth = 30 * scale;
  float neckHeight = 80*(1+cos(millis() * 0.001)) * scale;
  float yTopOfNeck = yTopOfBody - neckHeight;
  rect(-neckWidth/2, yTopOfNeck, neckWidth, neckHeight);
  
  //draw head of robot
  float headWidth = 140 * scale;
  float headHeight = 30 * scale;
  float yTopOfHead = yTopOfNeck - headHeight;
  rect(-headWidth/2, yTopOfHead, headWidth, headHeight);
}
