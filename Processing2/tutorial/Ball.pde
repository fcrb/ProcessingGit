class Ball {
  float x = width /2;
  float y = height /2;
  
  void draw() {
    strokeWeight(5);
    stroke(0);
    ellipse(mouseX, mouseY, 50, 50);
  }
}
  
