ArrayList<Ball> balls;
float ballDropIntervalMillis = 200;
float lastBallDropTimeMillis;
float accelerationPerFrame = .3;
float vBounceX = 0.68;
float vBounceY = -2;
int numRows = 16;
int[] binCount;
float probabilityOfGoingRight = 0.5;

void setup() {
  size(640, 640);
  balls = new ArrayList<Ball>();
  binCount = new int[numRows + 1];
  lastBallDropTimeMillis = millis();
}

void draw() {
  background(255);
  pushMatrix();
  float pinDiameter = pinSeparation() * 0.1;
  noStroke();
  fill(0, 0, 255);
  translate(width/2, topPinHeight());
  //draw pins
  for (int r = 0; r < numRows; ++r) {
    for (int pin = 0; pin <= r; ++pin) {
      ellipse( (-(r) * 0.5 + pin) * pinSeparation()
        , r * rowSeparation()
        , pinDiameter, pinDiameter);
    }
  }

  //make sure balls are dropping at specified rate
  float timeNowMillis = millis();
  int ballsToAdd = (int) ((timeNowMillis - lastBallDropTimeMillis) / ballDropIntervalMillis);
  if (ballsToAdd > 0) {
    for (int i = 0; i < ballsToAdd; ++i) {
      balls.add(new Ball());
    }
    lastBallDropTimeMillis = timeNowMillis;
  }

  //select balls that have dropped off screen
  ArrayList<Ball> ballsToRemove = new ArrayList<Ball>();
  for (Ball ball: balls) {
    ball.draw();
    if (ball.allDone()) {
      ballsToRemove.add(ball);
    }
  }

  for (Ball ball: ballsToRemove) {
    binCount[ball.bin] += 1;
    balls.remove(ball);
  }
  popMatrix();

  //draw histogram
  float heightScalar = (height - topPinHeight() - numRows * rowSeparation()) / max(binCount);
  if (heightScalar > 1)
    heightScalar = 1;
  float xShift = width/2 - pinSeparation() * (numRows + 1) * 0.5;
  for (int i =0; i < binCount.length; ++i) {
    float barHeight = heightScalar * binCount[i];
    float x = xShift + i * pinSeparation();
    float y = height - barHeight;
    rect(x, y, pinSeparation(), barHeight);
    String label = ""+binCount[i];
    text(""+binCount[i], x+ (pinSeparation() - textWidth(label))*0.5, y-2);
  }
}

float pinSeparation() {
  return 30;
}

float rowSeparation() {
  return pinSeparation() * sqrt(3) * 0.5;
}

float topPinHeight() {
  return height / 6;
}

class Ball {
  float x = 0, y = - topPinHeight() * (0.7 + random(0.3));
  float vx = 0, vy = 0;
  int currentRow = -1;
  int bin = 0;

  void draw() {
    int row = (int) (y / rowSeparation()) ;
    if (row >= numRows) {
      vx = 0;
    } 
    else
      if (row > currentRow) {
        if (currentRow == -1) {
          currentRow = 0;
          y=0;
        } 
        else {
          currentRow = row;
        }     
        //bounce
        vx = (random(1)> probabilityOfGoingRight)? abs(vBounceX) : -abs(vBounceX);
        if (vx > 0) ++bin;
        vy = vBounceY;
      }
    x += vx; 
    y += vy;
    vy += accelerationPerFrame;
    float ballDiameter = 3;
    stroke(255, 0, 0);
    ellipse(x, y, ballDiameter, ballDiameter);
  }

  boolean allDone() {
    return y > height;
  }
}
