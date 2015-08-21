float x, y;
void setup() {
  size(480, 240);
  background(0);
  x = mouseX;
  y = mouseY;
  frameRate(60);
}

void draw() {
  //fill black, with some alpha, so that existing image fades away gradually
  fill(0, 10);
  noStroke();
  rect(0, 0, width, height);

  fill(0, 255, 0);
  float easing = 0.1;
  x += easing * (mouseX - x);
  y += easing * (mouseY - y);
  ellipse(x, y, 30, 30);
}



