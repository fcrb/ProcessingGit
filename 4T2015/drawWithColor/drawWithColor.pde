int backgroundColor = color(255);

void setup() { 
  size(640, 480); //for browser
  background(backgroundColor);
}

void draw() {
  float xDiameter = width/20, yDiameter = height/20;
  fill(255,0,0);
  noStroke();
  ellipse(mouseX, mouseY, xDiameter, yDiameter);
}

void keyPressed() {
  background(backgroundColor);
}
