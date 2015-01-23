int MAX_BRANCH_LEVEL = 9;
float angleInDegrees = 15;
float MAX_ANGLE_DEGREES = 30;
float trunkHeightMultiplier = 0.2;
float angleShiftInDegrees = 0;
int Y_AXIS = 1;
int X_AXIS = 2;

void setup() {
  size(480, 360);
}

void draw() { 
  background(255);
  //draw sky
  float horizonHeight = height * 0.5;
  setGradient(0, 0, width, horizonHeight, color(0, 0, 200), color(150, 0, 0), Y_AXIS);
  //draw ground
  fill(0, 80, 0);
  rect(0, horizonHeight, width, height);
  pushMatrix();
  //move (0,0) to middle of screen (approximately)
  translate(width/2, height*0.9);
  //flip y-axis so that increasing y moves up screen
  scale(1, -1);

  if (keyPressed) {
    //blow the tree left or right
    if (key == 'a') {
      if (angleShiftInDegrees < MAX_ANGLE_DEGREES) {
        ++angleShiftInDegrees;
      }
    }
    if (key == 'd') {
      if (angleShiftInDegrees > -MAX_ANGLE_DEGREES) {
        --angleShiftInDegrees;
      }
    }
  } else {
    //wind is not blowing, let tree ease back to upgright
    angleShiftInDegrees *= 0.97;
  }

  drawTree(0);
  popMatrix();
  fill(0, 200, 0);
  String help = "use 'a' and 'd' keys to make wind blow";
  text(help, (width - textWidth(help))/2, height * 0.95);
}

void drawTree(int level) {
  if (level > MAX_BRANCH_LEVEL) {
    return;
  }
  //higher levels have thinner trunks...
  float trunkThickness = width * 0.025 * pow(0.8, level);
  strokeWeight(trunkThickness);
  stroke(0);
  float trunkHeight = height * trunkHeightMultiplier * pow(0.8, level);
  line(0, 0, 0, trunkHeight);
  //make top of trunk the new center of screen
  translate(0, trunkHeight);
  //draw left branch (another tree). First, rotate
  float angleInRadians = angleInDegrees * PI /180;
  float angleShiftInRadians = (angleShiftInDegrees + noise(millis()*0.002)) * PI /180;
  pushMatrix();
  rotate(angleInRadians + angleShiftInRadians);
  drawTree(level + 1);
  popMatrix();
  //draw right branch (another tree). First, rotate
  pushMatrix();
  rotate(-angleInRadians + angleShiftInRadians);
  drawTree(level + 1);
  popMatrix();
  
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  } else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
