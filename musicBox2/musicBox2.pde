MusicBoxNode masterNode;
//int numberNodes = 20;
float nodeSize = 0.5;

void setup() {
  size(640, 640);
  masterNode = new MusicBoxNode(null, 0, 0, 0, 10, 0);
  masterNode.extend(20, width/2 * 0.95);
  masterNode.extend(16, width/2 * 0.95);
 //masterNode.extend(10, width/2);
}

void draw() {
  background(0);
  noStroke();
  masterNode.drawNodes();
}

