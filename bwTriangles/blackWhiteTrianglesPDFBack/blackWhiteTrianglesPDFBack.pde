import processing.pdf.*;
PFont logoFont, numberFont;

int izzyNumber = 0;
int uniqueCombinations = 0;
int polySides = 3;
float s;

void setup() {
  size(864, 864, PDF, "blackWhiteTranglesPDFBack.pdf");
  translate(width/2, height/2);
  background(255, 255);
  s = width / 4;
  rotate(PI/4);

  float size = 100;
  logoFont = createFont("CMUSerif-Italic", size); //"CMUSerif-Italic", 32);
  numberFont = createFont("CMUSerif-Roman", size); //"CMUSerif-Italic", 32);
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
  noStroke();
  fill(0);

  pushMatrix();
  translate(0, s * sqrt(3) / 4 - s/(2 * sqrt(3)));

  //triangle #
  String num = ""+uniqueCombinations;
  textFont(numberFont);
  float textSize = 32;
  textSize(textSize);
  //Can't figure out why this is happening, but...
  if (uniqueCombinations == 1) {
    text(num, -textWidth(num)/2, -textSize * 1.2);
  }
  else {
    text(num, 0, -textSize * 1.2);
  }

  //logo
  textSize = 24;
  mrb(-textSize * 0.3, textSize * 0.4, textSize);
  popMatrix();

  //borders
  noFill();
  stroke(255, 0, 0);
  strokeWeight(1);
  triangle(-s / 2, s * sqrt(3) / 4, 
  s / 2, s * sqrt(3) / 4, 
  0, -s * sqrt(3) / 4);
  popMatrix();

  ++izzyNumber;
}

