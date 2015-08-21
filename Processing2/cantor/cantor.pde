import processing.pdf.*;
float cantorFraction = 1.0/3;
int maxLevel = 5;

void setup() {
  size(200, 800, PDF, "cantor.pdf");
  background(255);
  strokeWeight(72/1000.0);

  float widthFraction = 0.9;
  float yDelta = height / (maxLevel + 1);
  float y = height * (1-widthFraction) * 0.5; ;
  float leftEdge = width * (1-widthFraction) * 0.5; 
  float rightEdge = leftEdge + widthFraction * width; 
  line(leftEdge, y, rightEdge, y);
  line(leftEdge, y, leftEdge, y + yDelta);
  line(rightEdge, y, rightEdge, y + yDelta);
  drawCantor(leftEdge, width * widthFraction, y + yDelta, yDelta, 1);
}

void drawCantor(float left, float w, float y, float yDelta, int level) {
  if (level >= maxLevel) {
    line(left, y, left+w, y);
    return;
  }

  //draw verticals on left
  line(left, y, left, y + yDelta);
  float ySecondVertical = left + (1-cantorFraction)* 0.5 * w; 
  line(ySecondVertical, y, ySecondVertical, y + yDelta);
  
  //draw middle bar
  float yThirdVertical = ySecondVertical + cantorFraction * w; 
  line(ySecondVertical, y, yThirdVertical, y);
  
  //draw verticals on right
  line(yThirdVertical, y, yThirdVertical, y + yDelta);
  line(left + w, y, left + w, y + yDelta);

  float nextGenWidth = (1-cantorFraction)* 0.5 * w;
  float yDeltaMultiplier = 1.0;
  drawCantor(left, nextGenWidth, y + yDelta, yDelta * yDeltaMultiplier, level +1); 
  drawCantor(yThirdVertical, nextGenWidth, y + yDelta, yDelta * yDeltaMultiplier, level +1); 
}
