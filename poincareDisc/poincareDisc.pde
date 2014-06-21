float u1 = 0.78, u2=-0.58;
float diameter, radius;

void setup() {
  size(480, 480);
  diameter = width * 0.95;
  radius = diameter * 0.5;
}

void draw() {
  background(0);
  translate(width/2, height/2);
  noFill();
  stroke(50);
  strokeWeight(2);
  // draw edge of Poincare disk
  ellipse(0, 0, diameter, diameter);
  if (mousePressed) {
    handleMouse();
  }
  //draw point
  stroke(255);
  float pointSize = 6;
  fill(255);
  ellipse(u1 * radius, -u2 * radius, pointSize, pointSize);
  //mX and mY will be translated into x,y coordinates
  //as though the disk is a unit circle
  noFill();
  float v1 = mouseXToUnitDisk();
  float v2 = mouseYToUnitDisk();

  if (v1*v1 + v2*v2 < 1) {
    //draw only if mouse is in circle
    float denom = u1*v2-u2*v1;
    float a = (u2*(v1*v1+v2*v2)-v2*(u1*u1+u2*u2)+u2-v2)/denom;
    float b = (v1*(u1*u1+u2*u2)-u1*(v1*v1+v2*v2)+v1-u1)/denom;

    float lineDiameter = sqrt(a*a/4+b*b/4-1) * radius * 2;
    if (lineDiameter > width * 25) {
      //large diameters cause instability, so we just draw a line,
      //which is close enough.
      float dx = 100 * (mouseX - width/2 - u1 * radius);
      float dy =100 * (mouseY - height /2 + u2 * radius);
      line(u1 * radius - dx, -u2 * radius- dy, mouseX - width/2+dx, mouseY - height /2 +dy);
    } 
    else {
      //circle isn't too big, so draw it
      float ctrX = - a / 2 * radius;
      float ctrY = b / 2 * radius;
      ellipse(ctrX, ctrY, lineDiameter, lineDiameter);
    }
  }
  // trim off the part of the ellipse that extends outside the disk.
  // could implement with arc, but this is so much easier.
  strokeWeight(diameter - 1);
  stroke(0);
  ellipse(0, 0, 2 * diameter, 2 * diameter);
}

float mouseXToUnitDisk() {
  return (mouseX - width/2) / radius;
}

float mouseYToUnitDisk() {
  return (height/2 - mouseY) / radius;
}

void handleMouse() {
  float u1_ = mouseXToUnitDisk();
  float u2_ = mouseYToUnitDisk();
  if (u1_ * u1_ + u2_ * u2_ < 1) {
    u1 = u1_; 
    u2 = u2_;
  }
}
