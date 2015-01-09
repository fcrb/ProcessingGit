Robot robbie, ruth;

void setup() {
  size(480, 320);
  
  robbie = new Robot(100);
  ruth = new Robot(50);
}

void draw() {
  background(#FFFFC0);
  
  robbie.easeTowards(mouseX,mouseY);
  ruth.easeTowards(robbie.x,robbie.y);
  robbie.drawRobot();
  ruth.drawRobot();
}
