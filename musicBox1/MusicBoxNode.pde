class MusicBoxNode {
  float xRadius_,  yRadius_,  frequency_,  radius_;
  color colorValue_;

  MusicBoxNode(float x, float y, float f, float r, color c) {
    xRadius_ = x;
    yRadius_ = y;
    frequency_ = f;
    radius_ = r;
    colorValue_ = c;
  }
  
  float x(float time) {
    return cos(frequency_ * time) * xRadius_;
  }
  
  float y(float time) {
    return sin(frequency_ * time) * yRadius_;
  }
  
  float radius() {
    return radius_;
  }
  
  color colorValue() {
    return colorValue_;
  }
    
}
