float xRotation = 0;
void setup() {
  size(300, 300, P3D);
}

void draw() {
  background(0);
  translate(mouseX, mouseY);
  fill(0, 255, 0);
  stroke(0, 180, 0);
  lights();

  if (keyPressed) {
    if (key == 'w') {
      xRotation += 0.05;
    }
  }
  rotateX(xRotation);
  float radius = height * 0.15 *(1.2 + sin(frameCount*0.02));
  sphere(radius);
}
