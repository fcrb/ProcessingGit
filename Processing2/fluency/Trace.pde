class TraceBall {
  float x, y, easing;

  TraceBall(float easing_) {
    x = width/2;
    y = height/2;
    easing = easing_;
  }

  void drawBall() {
    pushMatrix();
    noStroke();
    x += (mouseX - x) * easing;    
    y += (mouseY - y) * easing;
    float radius = easing * 20.0;
    ellipse(x, y, radius, radius);
    popMatrix();
  }
}

