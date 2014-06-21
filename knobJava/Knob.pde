class Knob {
  float x, y, diameter, angle, minValue, maxValue;

  Knob(float x_, float y_, float d, float min_, float max_) {
    x = x_;
    y=y_;
    diameter = d;
    angle = PI/2;
    minValue = min_;
    maxValue=max_;
  }

  void draw() {
    pushMatrix();
    if (mousePressed) {
      //inside dial?
      if (dist(mouseX, mouseY, x, y) < diameter/2) {
        angle = rotationAngle(mouseX - x, mouseY - y);
      }
    }
    translate(x, y);
    rotate(-angle);
    noStroke();
    fill(200);
    //knob
    ellipse(0, 0, diameter, diameter);
    float diameterScalar = 0.8;
    stroke(controlColor);
    strokeWeight(2);
    noFill();
    //inset ring
    ellipse(0, 0, diameter*diameterScalar, diameter*diameterScalar);
    fill(0);
    strokeWeight(4);
    line(0, 0, diameter * 0.45, 0);
    popMatrix();
  }
}

float rotationAngle(float pointToX, float pointToY) {
  if (pointToX == 0)
    return pointToY > 0 ? -PI / 2 : PI /2;
  float a = atan(abs(pointToY/pointToX));
  if (pointToY == 0)
    return pointToX > 0 ? 0 : PI;
  if (pointToY < 0) {
    //quadrants 1 & 2
    return (pointToX > 0) ? a : PI - a;
  } 
  //quadrants 3 & 4
  return (pointToX > 0) ? -a : a - PI;
}
