class Hermit {
  float x = width/2, y = height/2;
  float radius = width/20;
  color c = color(255,0,0);
  
  void drawIt() {
    fill(c);
    noStroke();
    ellipse(x, y, radius, radius);
  }
}
