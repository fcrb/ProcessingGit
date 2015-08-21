float rotation = PI /12;
float scaleDown = 0.9;
int maxLevel = 9;

float cosR = cos(rotation);
float sinR = sin(rotation);

void setup() {
  size(640, 550);
  
  int bgColor = 255;
  background(bgColor);

  drawTree(width/2, height * 0.9, width/2, height * 0.77, 0);
}

void drawTree(float x1, float y1, float x2, float y2, int level) {
  if (level > maxLevel) {
    return;
  }
  //draw the trunk of the tree
  line(x1, y1, x2, y2);
  
  //create two branches, each of which is another tree (recursion!)
  drawTree(x2, y2, x2 + scaleDown * (cosR*(x2-x1) - sinR*(y2 - y1)), y2 + scaleDown * (sinR*(x2-x1) + cosR*(y2 - y1)), level + 1);
  drawTree(x2, y2, x2 + scaleDown * (cosR*(x2-x1) + sinR*(y2 - y1)), y2 +scaleDown * (- sinR*(x2-x1) + cosR*(y2 - y1)), level + 1);
}
