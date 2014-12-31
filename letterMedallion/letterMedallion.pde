import processing.pdf.*;
PFont font;
//font parameters
String letter = "b";
boolean includeRing = true;

float txtSizeScalar = 0.8;
float fontVerticalAdjust = 0.22;
float strokeWeightScalar = 0.05;
float horizontalLetterShiftScalar = 1;// c is 1. 25

//tree parameters
//original prints
int maxLevel = 7;
float rotation = PI * 0.14;
float branchLengthMultiplier = 0.75;
float thicknessScalar = 0.02;
float trunkScale = 0.08; 
float treeDistFromCenter = 0.175; 
int numTrunks = 9;

//other
boolean needsRedraw = true;
float heightScaleToAccommodateRing = 1.05;
boolean printingReviewOn = false;
boolean lineStarted = false;
int xTrans, yTrans;
int BASE_WIDTH = 800;

void setup() {
  int w = 800;//BASE_WIDTH;
  size(w, (int) (w * heightScaleToAccommodateRing));
  initializeEdgeCalculator();
  font = createFont("Herculanum", 32);
  //  font = createFont("Lucida Calligraphy", 32);
  textFont(font);
  xTrans = width/2;
  yTrans = height - width/2;
}

void scaledLine(float x0, float y0, float x1, float y1) {
  line(x0 * width / BASE_WIDTH, y0 * width / BASE_WIDTH, x1 * width / BASE_WIDTH, y1 * width / BASE_WIDTH);
}

void keyPressed() {
  if (key == 'p') {
    printingReviewOn = !printingReviewOn;
    if (printingReviewOn) {
      String fileName = letter;
      if(!includeRing) {
        fileName += "_noRing";
      }
      createEdgeOnlyPDF(fileName+".pdf", 72*12);
    }
    boolean needsRedraw = true;
    return;
  }
}

void drawMouseCoordinates() {
  noStroke();
  fill(255);
  rect(0, 0, 80, 20);
  textSize(12);
  fill(0);
  text(""+(mouseX-xTrans)+","+(mouseY-yTrans), 3, 10);
}

void draw() {
  //  drawMouseCoordinates();
  if (!needsRedraw) return;
  needsRedraw = false;
  background(255);
  translate(xTrans, yTrans);
  float treeBase = height * treeDistFromCenter;
  rotate(2 * PI / numTrunks / 2);
  for (int i = 0; i < numTrunks; ++i ) {
    drawTree(0, -treeBase, 0, -treeBase -height * trunkScale, 0); 
    rotate(2 * PI / numTrunks);
  }
  rotate(-2 * PI / numTrunks / 2);

  //draw letter
  float txtSize = width * txtSizeScalar; 
  textSize(txtSize); 
  fill(0); 
  text(letter, -textWidth(letter)/2 * horizontalLetterShiftScalar, txtSize*(0.5 - fontVerticalAdjust)); 
  noFill(); 
  stroke(0); 
  float strokeWt = width * strokeWeightScalar; 
  strokeWeight(strokeWt); 
  float diameter = width - strokeWt; 
  ellipse(0, 0, diameter, diameter);
  stroke(255);
  float treeTrimWidth = width / 4;
  strokeWeight(treeTrimWidth);
  ellipse(0, 0, diameter + treeTrimWidth, diameter + treeTrimWidth);

  //put a ring on it
  if (includeRing) {
    stroke(0);
    strokeWeight(strokeWt/2);
    float ringDiameter = diameter / 10;
    ellipse(0, - (diameter + ringDiameter - strokeWt)/2, ringDiameter, ringDiameter);
  }

//  drawManualLines();
}



void drawTree(float x1, float y1, float x2, float y2, int level) {
  if (level >= maxLevel) {
    return;
  }
  // draw the trunk of the tree
  stroke(0); 
  strokeWeight(sqrt(1.0 - (float)level / maxLevel)* width * thicknessScalar); 
  line(x1, y1, x2, y2); 

  // create two branches, each of which is another tree (recursion!)
  //  float angleScale = 2.0f * mouseY / height;
  float angleShift = 0; //(0 - width * 0.5f) / width * rotation;
  float angle = (rotation + angleShift);// * angleScale; 
  float cosR = cos(angle); 
  float sinR = sin(angle); 
  drawTree(x2, y2, 
  x2 + branchLengthMultiplier * (cosR * (x2 - x1) - sinR * (y2 - y1)), y2
    + branchLengthMultiplier * (sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1); 
  angle = (rotation - angleShift);// * angleScale; 
  cosR = cos(angle); 
  sinR = sin(angle); 
  drawTree(x2, y2, 
  x2 + branchLengthMultiplier * (cosR * (x2 - x1) + sinR * (y2 - y1)), y2
    + branchLengthMultiplier * (-sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1);
}
