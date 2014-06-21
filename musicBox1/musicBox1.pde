ArrayList<MusicBoxNode> nodes;
int numberNodes = 100;
float nodeSize = 0.2;

void setup() {
  size(640, 480);
  nodes = new ArrayList<MusicBoxNode>();
  for (int i = 0; i < numberNodes; ++i) {
    float fractionalRadius = 0.5  * (i + 1.0) / numberNodes; 
    float frequency = numberNodes - i; 
    float radius = nodeSize *  (i+1);
    int redValue =  i * 3;
    color c = color( redValue, 255 - redValue, 0);
    nodes.add(new MusicBoxNode(width  * fractionalRadius, height * fractionalRadius, frequency, radius, c));
  }
}

void draw() {
  background(0);
  noStroke();
  float time = millis() * 0.00002;
  for (MusicBoxNode node : nodes) {
    fill(node.colorValue());
    ellipse(width/2 + node.x(time), height/2 - node.y(time), node.radius(), node.radius());
  }
}

