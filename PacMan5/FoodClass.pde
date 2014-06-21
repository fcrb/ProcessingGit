class Food {
  float diameter = 10;
  int x, y;
  int clr;
  boolean eaten = false;

  Food() {
    x = gridify(random(0, width));
    y = gridify(random(0, height));
    float r = random(0,255);
    float g = random(0,255);
    float b = random(0,255);
    float maxColor = max(r,max(b,g));
    r *= 255 / maxColor;
    g *= 255 / maxColor;
    b *= 255 / maxColor;
    clr = color(r,g,b);
  }

  void draw() {
    pushMatrix();
    noStroke();
    translate(x, y);
    fill(clr);
    ellipse(0, 0, diameter, diameter);
    popMatrix();
    if(dist(x,y,pacMan.x, pacMan.y) < diameter/2) {
      eaten = true;
    }
  }
}
