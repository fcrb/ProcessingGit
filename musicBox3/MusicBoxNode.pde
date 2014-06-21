class MusicBoxNode {
  MusicBoxNode parent_;
  float xRadius_, yRadius_, frequency_, radius_;
  color colorValue_;
  ArrayList<MusicBoxNode> nodes;

  //  MusicBoxNode(float x, float y) {
  //    this(null,x, y, 0, 0, 0);
  //  }

  MusicBoxNode(MusicBoxNode p, float x, float y, float f, float r, color c) {
    parent_ = p;
    xRadius_ = x;
    yRadius_ = y;
    frequency_ = f;
    radius_ = r;
    colorValue_ = c;
  }

  void extend(int numberLeafNodes, float maxRadius) {
    if (nodes== null) {
      nodes = new ArrayList<MusicBoxNode>();
      for (int i = 0; i < numberLeafNodes; ++i) {
        float fractionalRadius =  (i + 1.0) / numberLeafNodes; 
        float frequency = numberLeafNodes - i; 
        float radius = nodeSize *  (i+5);
        int redValue =  (int)(i * 255.0  / numberLeafNodes);
        color c = color( 0, redValue, 255 - redValue);
        nodes.add(new MusicBoxNode(this, maxRadius  * fractionalRadius, maxRadius * fractionalRadius, frequency, radius, c));
      }
    } 
    else {
      for (MusicBoxNode node : nodes) 
        node.extend(numberLeafNodes, maxRadius * 2 / numberLeafNodes);
    }
  }

  float x(float time) {
    return cos(2 * frequency_ * time) * xRadius_;
  }

  float y(float time) {
    return sin(1 * frequency_ * time) * yRadius_;
  }

  float radius() {
    return radius_;
  }

  color colorValue() {
    return colorValue_;
  }

  void drawNodes() {
    if (nodes == null) {
      fill(colorValue_);
      float time = millis() * 0.00005;
      ellipse(width/2 + parent_.x(time) + x(time), height/2 + parent_.y(time) + y(time), radius(), radius());
      return;
    }
    for (MusicBoxNode node : nodes)
      node.drawNodes();
  }
}

