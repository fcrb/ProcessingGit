Ball myBall;
public void setup() {
  size(400, 300);
  myBall = new Ball();
  background(235);
}

void draw() {
  noStroke();
  fill(255, 20);
  rect(0,0,width, height);
  
  myBall.draw();
}
