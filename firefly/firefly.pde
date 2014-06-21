float x = mouseX, y= mouseY;
void setup() {
  size(320, 180);
  background(0);
}

void draw() {
  background(0);
  noStroke();
  float diameterFractionOfHeight = 0.3;
  float easing = 0.1;
  x += easing * (mouseX - x);
  y += easing * (mouseY - y);
  for (float diameter = height * diameterFractionOfHeight; diameter > 0; diameter -= height *diameterFractionOfHeight* 0.05) {
    float colorValue  = 255.0 * (1 - diameter / height / diameterFractionOfHeight);
    fill(colorValue, colorValue, 0);
    ellipse(x, y, diameter, diameter);
  }
}

