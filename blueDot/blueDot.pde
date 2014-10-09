void setup() {
  size(640,480);
}

void draw() {
  background(0);
  float x = mouseX;
  float y = mouseY;
  float xDiameter = 100;
  float yDiameter = 100;
  
  //color the dot blue using RGB
  fill(0,0,255);
  ellipse(x, y, xDiameter, yDiameter);
}
