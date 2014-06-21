import processing.opengl.*;

void setup() {
  size(480, 270, OPENGL);
}

void draw() {
  background(255);

  smooth();
  stroke(0, 0, 255);
  translate(width/2, height/2, 0);
  rotateY(frameCount * 0.06);
  rotateX(PI * .45);
  float w = width/3;
  float h = width/3;
  float c = 255;
  noFill();
  for (int i = 0; i< 3; ++i) {
    stroke(255-c, 0, c);
    box(w, h, h * 0.6);
    w *= 0.5;
    h *= 0.5;
    c *= 0.5;
  }
  fill(255,0,0);
  box(w, h, h * 0.6);
}



