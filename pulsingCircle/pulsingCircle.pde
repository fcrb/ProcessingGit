
void setup() {
  size(100, 100);
  frameRate(30);
}

void draw() {
  background(255);
  stroke(10,100,255);
  strokeWeight(5 * sin(frameCount/2)+10);
  fill(0);
  ellipse(width/2, height/2, 40, 40);
}

