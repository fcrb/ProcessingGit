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
class Ball {
  float vx, vy, vz;
  float x, y, z;
  float radius = 20;
  int colr;

  Ball(float x_, float y_, float z_, float vx_, float vy_, float vz_, float r, int color_, Box ballBox_) {
    x = x_;
    y=y_;
    z=z_;
    vx=vx_;
    vy=vy_;
    vz=vz_;
    radius = r;
    ballBox = ballBox_;
    colr = color_;
  }

  void draw() {

    stroke(colr);
    x += vx;
    if (abs(x) > ballBox.xLength/2 - radius) {
      vx = - abs(vx) * sign(x);
    }

    y += vy;
    vy += 0.02;
    if (y > ballBox.yLength/2-radius) {
      vy = - abs(vy);
    }

    z += vz;
    if (abs(z) > ballBox.zLength/2-radius) {
      vz = - abs(vz)* sign(z);
    }

    pushMatrix();
    translate(x, y, z);
    sphere(radius);
    popMatrix();
  }
}
class Box {
  /*
  I can imagine this class answering whether it contains a point.
  For now, the interface will just be x, y, and z length of Box.
  */
  float xLength = width/3;
  float yLength = width/3;
  float zLength = width/3;

  void draw() {
    noFill();
    box(xLength, yLength, zLength);
  }
  
}

