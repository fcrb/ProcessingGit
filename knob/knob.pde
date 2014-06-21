color bgColor = color(0);
float diameter = 90;

void setup() {
  size(360, 360);
}

void draw() {
  background(bgColor);
  ellipse(width/2, height/2, diameter, diameter);
}

void setDiameter(float d) {
  diameter = d;
}

