ArrayList<Ball> balls;
int framesBetweenBalls = 15;
int numFramesToRecord = framesBetweenBalls;
int frameCounter = 0;
float diameter = 50;
float ay = .1;
float vx = 4.7;

void setup() {
  size(500, 500);
  balls = new ArrayList<Ball>();
  frameRate = 30;
}

void draw() {
  if (frameCounter >= numFramesToRecord) {
    return;
  }
  if (frameCount % framesBetweenBalls == 1) 
    balls.add(new Ball());
  background(255);
  fill(255, 0, 0);
  noStroke();
  for (Ball ball: balls) {
    ball.draw();
  }

  //first ball must be offscreen before we record
  if (!balls.get(0).offScreen()) {
    return;
  };
  frameCounter++;
  saveFrame("ballgif-###.png");
}

