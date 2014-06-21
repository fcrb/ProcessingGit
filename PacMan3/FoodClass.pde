class Food {
  float diameter = 20;
  float x, y;
  int clr;

  Food() {
    x = random(0, width);
    y = random(0, height);
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
  }
}
