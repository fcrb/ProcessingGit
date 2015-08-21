void setup() {
  size(640, 360); 
  stroke(255);
  noFill();
  strokeWeight(10);
}

void draw() {
  background(0);
  float xScale = 1.3;
  //  bezier(0, 0, mouseX * xScale, 0, mouseX * xScale, height, 0, height);
  //ellipse(0, height/2, mouseX * 2, height);
  translate(width/2, height/2);
  rotate(rotationAngle(mouseX - width/2, mouseY - height/2));
  ellipse(0, 0, width/3, width/6);
  line(-width, 0, width, 0);
}

float rotationAngle(float pointToX, float pointToY) {
  //a bit of trig...

  //now, deal with the fact that atan may be off by 180 degrees,
  //so we may need to add PI radians
  if (pointToX == 0) {
    return ( pointToY < 0 )?PI: -PI;
  }
  float rotationAngleInRadians = atan( pointToY / pointToX  ) ;
  if (pointToX < 0)
    rotationAngleInRadians += PI;
  return rotationAngleInRadians;
}

