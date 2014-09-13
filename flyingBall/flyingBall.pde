ArrayList<Ball> balls;
int numberFramesPerBall = 10;
int numberFramesToSkipBeforeRecording = 100;

void setup() {
  size(500, 500);
  balls = new ArrayList<Ball>();
}

void draw() {
  if(frameCount >= numberFramesToSkipBeforeRecording + numberFramesPerBall) {
    return;
  }
  background(255);
  
  if (frameCount % numberFramesPerBall == 0) {
    balls.add(new Ball());
  }

  for (Ball aBall: balls) {
    aBall.draw();
  }
  
  if(frameCount < numberFramesToSkipBeforeRecording) {
    return;
  }
  
  saveFrame("flyingBall-###.png");
  
}
