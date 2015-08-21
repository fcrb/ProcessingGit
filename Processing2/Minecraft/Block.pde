class Block {
  float x, y, z, vx, vy, vz, rx, ry, rz, rvx, rvy, rvz;
  int clr= color(100, 100, 255);
  float diameter = 15;
  //  BlockContainer container;

  Block() {
    x = y = z = 0;
  }

  Block(int x_, int y_, int z_) {
    x = x_;
    y = y_;
    z = z_;
  }

  void setInMotion() {
    vx = step();
    vy = step();
    vz = step();
    rx = ry = rz = 0;
    float rotationScale = 0.01;
    rvx = step() * rotationScale;
    rvy = step() * rotationScale;
    rvz = step() * rotationScale;
  }

  void draw() {
    bump();
    pushMatrix();
    //draw dots inside box
    stroke(clr);
    strokeWeight(2);
    translate(x, y, z);
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    fill(255, 255, 0);
    box(diameter, diameter, diameter);
    popMatrix();
  }

  void bump() {
    x += vx;
    y += vy;
    z += vz;
    vx = world.bounce(x, vx);
    vy = world.bounce(y, vy);
    vz = world.bounce(z, vz);
    rx += rvx;
    ry += rvy;
    rz += rvz;
  }

  float step() {
    float stepSize = 2;
    return random(-stepSize, stepSize);
  }
}
