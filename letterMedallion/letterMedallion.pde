PFont font;
float txtSize = 0.9;
float fontVerticalAdjust = 0.2;
String letter = "a";
float strokeWt = 0.07;

//tree parameters
int maxLevel = 6;
float rotation = PI * 0.25;
float scaleDown = 0.8;
float angleScale = 0.7;
float thickness = 4;
float trunkScale = 0.08; 
float treeDistFromCenter = 0.18; 
int numTrunks = 8;

void setup() {
  size(400, 400);
  font = createFont("Herculanum", 32);
//  font = createFont("Lucida Calligraphy", 32);
  textFont(font);

  background(255);
  translate(width/2, height/2);

  float treeBase = height * treeDistFromCenter;
  rotate(2 * PI / numTrunks / 2);
  for (int i = 0; i < numTrunks; ++i ) {
    drawTree(0, -treeBase, 0, -treeBase -height * trunkScale, 0); 
    rotate(2 * PI / numTrunks);
  }
  rotate(-2 * PI / numTrunks / 2);

  txtSize *= width; 
  strokeWt *= width; 
  thickness *= width; 
  textSize(txtSize); 
  fill(0); 
  text(letter, -textWidth(letter)/2, txtSize*(0.5 - fontVerticalAdjust)); 
  noFill(); 
  stroke(0); 
  strokeWeight(strokeWt); 
  float diameter = width - strokeWt; 
  ellipse(0, 0, diameter, diameter);
  stroke(255);
  float treeTrimWidth = 100;
  strokeWeight(treeTrimWidth);
  ellipse(0, 0, diameter + treeTrimWidth, diameter + treeTrimWidth);
}

void drawTree(float x1, float y1, float x2, float y2, int level) {
  if (level > maxLevel) {
    return;
  }
  // draw the trunk of the tree
  stroke(0); 
  strokeWeight(sqrt(maxLevel - level + 1)* thickness); 
  line(x1, y1, x2, y2); 

  // create two branches, each of which is another tree (recursion!)
  //  float angleScale = 2.0f * mouseY / height;
  float angleShift = 0; //(0 - width * 0.5f) / width * rotation;
  float angle = (rotation + angleShift) * angleScale; 
  float cosR = cos(angle); 
  float sinR = sin(angle); 
  drawTree(x2, y2, 
  x2 + scaleDown * (cosR * (x2 - x1) - sinR * (y2 - y1)), y2
    + scaleDown * (sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1); 
  angle = (rotation - angleShift) * angleScale; 
  cosR = cos(angle); 
  sinR = sin(angle); 
  drawTree(x2, y2, 
  x2 + scaleDown * (cosR * (x2 - x1) + sinR * (y2 - y1)), y2
    + scaleDown * (-sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1);
}
//ABCDEFGHIJKLMNOPQRSTUVWXYZ

