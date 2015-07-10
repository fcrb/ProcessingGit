class Range {
  FloatList y = new FloatList(width);
  int rangeColor;
  float dy;

  Range(int rangeColor_, float dy_) {
    rangeColor = rangeColor_;
    dy = dy_;
    for(int i = 0; i < width; ++i) {
      y.append(height/2);
    }
   for(int i = 0; i < width; ++i) {
      scroll();
    }
  }

  void draw() {
    fill(rangeColor);
    noStroke();
    beginShape();
    for (int x = 0; x < width; ++x) {
      vertex(x, y.get(x));
    }
    vertex(width, y.get(width - 1));
    vertex(width, height);
    vertex(0, height);
    endShape();
  }

  float shift() {
    return  random(dy) - (dy * (0.5 + (y.get(width-2) /height - 0.5)));
    
  }

  void scroll() {
    y = y.getSubset(1,width - 1);
    y.append(y.get(width-2) + shift());
  }
}
