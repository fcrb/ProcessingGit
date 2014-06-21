import processing.opengl.*;

ArrayList<Ball> balls;
Box ballBox;

void setup() {
  size(480, 270, OPENGL);
  ballBox = new Box();
  balls = new ArrayList<Ball>();
  balls.add(new Ball(0, 0, 0, 1, 0, 1.5, 20, color(255, 0, 0), ballBox));
  balls.add(new Ball(0, 0, 0, -0.4, 0, 0.5, 20, color(0, 255, 0), ballBox));
  lights();
}

void draw() {
  background(255);

  stroke(0, 0, 255);
  translate(width/2, height/2, 0);
  rotateX((height/2 - mouseY) * 0.003);
  rotateY((mouseX - width/2) * 0.003);

  ballBox.draw();
  for (Ball ball: balls) {
    ball.draw();
  }
}

int sign(float a) {
  return a > 0 ? 1 : -1;
}
