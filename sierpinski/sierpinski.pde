void setup() {
  size(640, 555);
  
  int bgColor = 255;
  background(bgColor);
  float fractionAcross = 0.1;
  float x1=width/2; 
  float y1 =  height * fractionAcross;
  float x2=width * fractionAcross;
  float y2=height * (1-fractionAcross);
  float x3=width * (1-fractionAcross); 
  float y3= height * (1-fractionAcross);
  fill(255,0,0);
  noStroke();
  triangle(x1, y1, x2, y2, x3, y3);

  fill(bgColor);
  drawSierpinski(x1, y1, x2, y2, x3, y3);
}

void drawSierpinski(float x1, float y1, float x2, float y2, float x3, float y3) {
  if (dist(x1, y1, x2, y2) < 1) {
    return;
  }
  triangle((x1 + x2) * 0.5, (y1 + y2) * 0.5, (x1 + x3) * 0.5, (y1 + y3) * 0.5, (x2 + x3) * 0.5, (y2 + y3) * 0.5);
  drawSierpinski(x1, y1, (x1 + x2) * 0.5, (y1 + y2) * 0.5, (x1 + x3) * 0.5, (y1 + y3) * 0.5);
  drawSierpinski((x1 + x2) * 0.5, (y1 + y2) * 0.5, x2, y2, (x2 + x3) * 0.5, (y2 + y3) * 0.5);
  drawSierpinski((x1 + x3) * 0.5, (y1 + y3) * 0.5, (x2 + x3) * 0.5, (y2 + y3) * 0.5, x3, y3);
}
