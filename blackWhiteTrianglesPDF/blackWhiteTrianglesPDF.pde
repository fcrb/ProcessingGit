int izzyNumber = 0;
int uniqueCombinations = 0;
int polySides = 3;
float s;
void setup() {
  size(640, 640);
  translate(width/2, height/2);
  background(255, 255);
  s = width / 4;
  rotate(PI/4);
  drawGrid();
}

void drawGrid() {
  // rotate(- PI/4);
  float xStart = - (s * (1.5));
  float x, y;
  x = xStart;
  y = -(3 *  sqrt(3)/4) * s;
  //top row
  for (int i = 0; i < 5; ++i) {
    x += s * 0.5;
    drawTriangle(x, y, i % 2 == 1);
  }
  //second row
  y += s / 2 * sqrt(3);
  x = xStart - s /2;
  for (int i = 0; i < 7; ++i) {
    x += s * 0.5;
    drawTriangle(x, y, i % 2 == 1);
  }
  //third row
  y += s / 2 * sqrt(3);
  x = xStart - s /2;
  for (int i = 0; i < 7; ++i) {
    x += s * 0.5;
    drawTriangle(x, y, i % 2 == 0);
  }
  //last row
  y += s / 2 * sqrt(3);
  x = xStart;
  for (int i = 0; i < 5; ++i) {
    x += s * 0.5;
    drawTriangle(x, y, i % 2 == 0);
  }
}

void drawTriangle(float x, float y, boolean flip) {
  //is this izzy new?
  boolean isNew = false;
  while (!isNew) {
    int testNumber = izzyNumber;
    isNew = true;
    for (int i = 0; i < 3; ++i) {
      //rotateByTwoBits
      testNumber = ((int)(testNumber / 4))  + ((testNumber % 4) * 16);
      if (testNumber < izzyNumber) {
        isNew = false;
      }
    }
    ++izzyNumber;
  }
  ++uniqueCombinations;
  --izzyNumber;

  pushMatrix();
  translate(x, y);
  if (flip) {
    rotate(PI);
  }
  if (izzyNumber > 63) return;
  noStroke();
  stroke(0);
  fill(0);
  int izzyCopy = izzyNumber;
  for (int i = 0; i < 6; ++i ) {
    if (izzyCopy % 2 == 0) {
      pushMatrix();
      translate(0, s * sqrt(3) / 4 - s/(2 * sqrt(3)));
      //draw black
      if (i == 0) {
        triangle(0, 0, 0, -s/sqrt(3), s/4, -s / (sqrt(3) * 4) );
      } 
      else if (i == 1) {
        triangle(0, 0, s/4, -s / (sqrt(3) * 4), s/2, s /(2 * sqrt(3)));
      }
      else if (i == 2) {
        triangle(0, 0, s/2, s /(2 * sqrt(3)), 0, s /(2 * sqrt(3)) );
      }
      else if (i == 3) {
        triangle(0, 0, 0, s /(2 * sqrt(3)), - s/2, s /(2 * sqrt(3)) );
      }
      else if (i == 4) {
        triangle(0, 0, - s/2, s /(2 * sqrt(3)), -s/4, -s / (sqrt(3) * 4)  );
      }
      else {
        triangle(0, 0, 0, -s/sqrt(3), -s/4, -s / (sqrt(3) * 4)  );
      }
      popMatrix();
    }
    izzyCopy = (int) (izzyCopy / 2);
  }

  //hairline
  noFill();
  stroke(255, 0, 0);
  strokeWeight(1.0/30);
  triangle(-s / 2, s * sqrt(3) / 4, 
  s / 2, s * sqrt(3) / 4, 
  0, -s * sqrt(3) / 4);
  //  text(""+uniqueCombinations,0,0);
  popMatrix();

  ++izzyNumber;
} 

