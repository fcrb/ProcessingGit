ArrayList<Robot> allMyLittleRobots = new ArrayList<Robot>();
int numberOfRobots = 15;

void setup() {
  size(480, 320);
  //create all of my robots
  float headWidth = 50; 
  for (int robotCtr = 0; robotCtr < numberOfRobots; ++robotCtr) {
    allMyLittleRobots.add(new Robot(headWidth, 0.1));
    headWidth *= 0.97;
  }
}

void draw() {
  background(#FFFFC0);

  //ease towards previous robot
  Robot previousRobot = allMyLittleRobots.get(0);
  previousRobot.easeTowards(mouseX,mouseY);
  for (int robotCtr = 1; robotCtr < numberOfRobots; ++robotCtr) {
    Robot nextRobot = allMyLittleRobots.get(robotCtr);
    nextRobot.easeTowards(previousRobot.x, previousRobot.y);
    previousRobot = nextRobot;
  }
  
  //draw the robots, in reverse order, so that robot
  //following mouse is on top
  for (int robotCtr = numberOfRobots - 1; robotCtr >= 0; --robotCtr) {
    allMyLittleRobots.get(robotCtr).drawRobot();
  }
}
