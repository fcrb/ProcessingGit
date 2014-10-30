import processing.pdf.*;
PFont myFont;

float nodeDiameter = 20;
float textSize_ = nodeDiameter * 0.6;
float rowSeparation = nodeDiameter * 1.5;
void setup() {
  size(400, 200, PDF, "binaryTree.pdf");
  myFont = createFont("CMUSerif-Roman", textSize_);
  textFont(myFont);
  background(255);

  float yFirstRow = nodeDiameter;
  int numNodes = 31;
  //arrows
  for (int i = 1; i <= numNodes/2; ++i) {
    float x = nodeX(i);
    float y = nodeY(i);
    line(nodeX(i), nodeY(i), nodeX(2 * i), nodeY(2 * i));
    line(nodeX(i), nodeY(i), nodeX(2 * i + 1), nodeY(2 * i + 1));
  }
  //nodes and labels
  textSize(textSize_);
  for (int i = 1; i <= numNodes; ++i) {
    float x = nodeX(i);
    float y = nodeY(i);
    fill(255);
    ellipse(x, y, nodeDiameter, nodeDiameter);
    fill(0);
    String label = ""+i;
    text(label, x - textWidth(label)*0.5, y+textSize_*0.33);
  }
  
}

float nodeX(int node) {
  float columnSeparation = ((float)width) / columnsInRowOfNode(node)/2;
  return (2 * column(node) + 1) * columnSeparation;
} 

float nodeY(int node) {
  return  nodeDiameter + rowSeparation * (level(node) - 1);
} 

int level(int node) {
  int lvlCounter = 0;
  while (node > 0) {
    ++lvlCounter;
    node /= 2;
  }
  return lvlCounter;
}

int columnsInRowOfNode(int node) {
  int lvl = level(node);
  int nodeInColumnZero = 1;
  for (int i = 1; i < lvl; ++i) {
    nodeInColumnZero *= 2;
  }
  return nodeInColumnZero;
}

int column(int node) {
  return node - columnsInRowOfNode(node);
}
