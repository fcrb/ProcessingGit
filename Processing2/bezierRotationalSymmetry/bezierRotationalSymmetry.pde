import processing.pdf.*;

int numRotations = 4;
float scaleIt = 0.7;
float strokeFractionOfWidth = 0.04;

void setup() {
  size(640, 640);
  beginRecord(PDF, "shamrock.pdf"); 
  drawShamrock();
  endRecord();
}

void drawShamrock() {
  background(255 );
  fill(0,255,0);
//  noFill();

  translate(width/2, height/2);
  noStroke();
  rectMode(CENTER);
  rect(0,0, height * 0.6, height * 0.6);
  strokeWeight(width * strokeFractionOfWidth);
  stroke(0);
  for (int i = 0; i < numRotations; ++i) {
    pushMatrix();
    scale(1, -1);
    drawSide(scaleIt);
    rotate( -PI/2);
    scale(-1, 1);
    drawSide(scaleIt);
    popMatrix();
    rotate(2 * PI/numRotations);
  }
  //  float centerCircleFraction = 0.35;
  //  fill(255);
  //  noStroke();
  //  ellipse(0,0,width * centerCircleFraction, height * centerCircleFraction);
}

void drawSide(float scaleIt) {
  float x1 = 0;//- width * 0.02;
  float y1 = height * 0.25;

  float x2 = x1;
  float y2 = height * 1;

  float x3 = width * 0.5;
  float y3 = height * 0.5;

  float secondAnchorScale = 0.8;
  float x4 = x3 * secondAnchorScale;
  float y4 = y3 * secondAnchorScale;

  bezier(x1 * scaleIt, y1 * scaleIt, x2 * scaleIt, y2 * scaleIt, 
  x3 * scaleIt, y3 * scaleIt, x4 * scaleIt, y4 * scaleIt);
}
