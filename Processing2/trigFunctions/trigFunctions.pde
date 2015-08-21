void setup() {
  size(160, 480);
}

void draw() {
  //set the origin to xBase, yBase (screen coordinates)
  float xBase = 0.1 * width;
  float yBase = height - xBase;
  translate(xBase, yBase);
  float theta = 0;
  //set theta to point towards mouse
  if (mouseX > xBase && mouseY < yBase) {
    theta = atan((yBase - mouseY) / (mouseX - xBase));
  } 
  float radius = height * 0.25;
  float tanTheta = tan(theta);
  //if you want the entire diagram to stay in view (by scaling),
  //uncomment the next 3 lines.
  //  if (tanTheta > 1)
  //    radius /= tanTheta;
  //  else radius *= tanTheta;
  background(255);
  noFill();
  stroke(150);
  float diameter = 2 * radius;

  //arc
  strokeWeight(1);
  stroke(150);
  arc(0, 0, diameter, diameter, -PI /2, 0);

  //base ray
  line(0, 0, radius, 0);

  //cosine
  stroke(0);
  strokeWeight(2);
  line(0, 0, radius * cos(theta), 0);

  //theta ray
  pushMatrix();
  rotate(-theta);
  float rayLength;
//  if (tanTheta < 1) {
//    rayLength = radius / sin(theta);
//  } 
//  else {
    rayLength = radius / cos(theta);
//  }
  stroke(0, 200, 0);
  line(0, 0, rayLength, 0);
  popMatrix();

  //sine
  float xCircle = radius * cos(theta);
  float yCircle = - radius * sin(theta);
  stroke(255,0,0);
  line(xCircle, 0, xCircle, yCircle);

  //tangent
  stroke(0, 0, 255);
  line(radius, 0, radius, yCircle/cos(theta));

  //cotangent
//  stroke(0);
//  line(0, -radius, xCircle/sin(theta), -radius);
}
