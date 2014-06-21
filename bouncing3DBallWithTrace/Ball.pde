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
