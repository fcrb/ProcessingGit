int backgroundColor = color(255);
float diameter = 10;

void setup() { 
  size(640, 480); //for browser
  background(backgroundColor);
}

void draw() {
  fill(backgroundColor, 10);
  rect(0, 0, width, height);
  fill(255, 0, 0);
  noStroke();
  ellipse(mouseX, mouseY, diameter, diameter);
  if (dist(mouseX, mouseY, pmouseX, pmouseY) > 2)  
    diameter /= 1.01;
  else 
    diameter *= 1.01;
}

void keyPressed() {
  background(backgroundColor);
}
