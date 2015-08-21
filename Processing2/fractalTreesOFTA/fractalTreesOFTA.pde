int MAX_LEVEL = 6;
void setup() {
  size(400, 400);
  translate(height/2, width/2);
  scale(1,-1);
  drawTree(0);
}


void drawTree(int level) {
  if (level > MAX_LEVEL) return;
  int treeHeight = 30;
  line(0, 0, 0, treeHeight);
  translate(0, treeHeight);
  float angle = PI /12;
  rotate(angle);
  pushMatrix();
  drawTree(level + 1);
  popMatrix();
  rotate(-angle * 2);
  pushMatrix();
  drawTree(level + 1);
  popMatrix();
}
