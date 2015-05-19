void setup() { 
  size(640, 480); //for browser
}

void draw() {
  float xDiameter = width/40, yDiameter = height/40;
  ellipse(mouseX, mouseY, xDiameter, yDiameter);
}

void keyPressed() {
  background(200);
}
