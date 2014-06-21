float sideLength;

void setup() {
  size(640, 640);
 
  translate(width/2, height/2);
  sideLength = width / 4;
 // rotate(- PI/4);
  float xStart = - (sideLength * (1.5));
  float x, y;
  x = xStart;
  y = -(3 *  sqrt(3)/4) * sideLength;
  //top row
  for (int i = 0; i < 5; ++i) {
    x += sideLength * 0.5;
    drawIt(x, y, i % 2 == 1);
  }
  //second row
  y += sideLength / 2 * sqrt(3);
  x = xStart - sideLength /2;
  for (int i = 0; i < 7; ++i) {
    x += sideLength * 0.5;
    drawIt(x, y, i % 2 == 1);
  }
  //third row
  y += sideLength / 2 * sqrt(3);
  x = xStart - sideLength /2;
  for (int i = 0; i < 7; ++i) {
    x += sideLength * 0.5;
    drawIt(x, y, i % 2 == 0);
  }
  //last row
  y += sideLength / 2 * sqrt(3);
  x = xStart;
  for (int i = 0; i < 5; ++i) {
    x += sideLength * 0.5;
    drawIt(x, y, i % 2 == 0);
  }
//  ellipse(0,0,5,5);
}


void drawIt(float x, float y, boolean flip) {
  pushMatrix();
  translate(x, y);
  if (flip) {
    rotate(PI);
  }
  triangle(-sideLength / 2, sideLength * sqrt(3) / 4, 
  sideLength / 2, sideLength * sqrt(3) / 4, 
  0, -sideLength * sqrt(3) / 4);
  popMatrix();
}

