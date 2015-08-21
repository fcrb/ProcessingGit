Player player;
Ball ball;

void setup() {
  size(480, 270);
  player = new Player();
  ball = new Ball();
  frameRate(60);
}

void draw() {
  background(255);
  player.draw();
  ball.draw();
}

class Player {
  private int numDiscs = 5;
  private float distanceToDiscCenters = 20;
  private float discDiameter = 10;
  private float noiseIncrement = 0.03;

  public void draw() {
    noStroke();
//    translate(mouseX, mouseY);
    for (int i = 0; i < numDiscs; ++i) {
      float angle = -  frameCount * 0.1 + i * 2 * PI / numDiscs;
      float r = map(noise(10 + i + frameCount*noiseIncrement), 0, 1, 0, 255);
      float g = map(noise(20 + i + frameCount*noiseIncrement), 0, 1, 0, 255);
      float b = map(noise(30 + i + frameCount*noiseIncrement), 0, 1, 0, 255);
      fill(r, g, b, 200);
      float x = mouseX + distanceToDiscCenters * cos(angle);
      float y = mouseY + distanceToDiscCenters * sin(angle);
      ellipse(x, y, discDiameter, discDiameter);
      if (dist(ball.x, ball.y, x, y)< (discDiameter + ball.ballDiameter)/2) {
        ball.newDirection(ball.x - x, ball.y - y);
      }
    }
  }
} 

class Ball {
  private float x = 0, y = 0, vx=5, vy = 0;
  private float vAcc = 0.1 ;
  private float ballDiameter = 20;

  public void draw() {
    vy += vAcc;
    y += vy;
    x += vx;
    if (y > height - ballDiameter/2) {
      vy = - 20 * sqrt(vAcc);
    }
    if (x < ballDiameter/2) {
      vx = abs(vx);
    }
    if (x > width - ballDiameter/2) {
      vx = -abs(vx);
    }
    fill(255, 0, 0);
    ellipse(x, y, ballDiameter, ballDiameter);
  }

  void newDirection(float dx, float dy) {
    float speed = dist(0, 0, vx, vy);
    float newLength = dist(0, 0, dx, dy);
    vx = dx * speed / newLength;
    vy = dy * speed / newLength;
  }
}
