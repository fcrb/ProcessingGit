int lastX;
int lastY;

void setup() {
  size(480, 240);
  lastX = mouseX;
  lastY = mouseY;
}

void draw() {
  if (mousePressed)
    line(lastX, lastY, mouseX, mouseY);
  lastX = mouseX;
  lastY = mouseY;
}
