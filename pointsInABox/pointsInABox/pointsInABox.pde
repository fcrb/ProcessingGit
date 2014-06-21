int numPoints = 1000;
float pointSize= 3;
int pointColor= color(100, 100, 255);

void setup() {
  size(640, 360, P3D);
}

void draw() {
  background(255);

  //make coordinates of center (0,0)
  translate(width/2, height/2, 0);

  //rotate to follow mouse
  float rotateScale = 0.01;
  rotateX((height/2-mouseY) * rotateScale);
  rotateY((mouseX-width/2) * rotateScale);

  //draw back wall of box
  float side = height/2;
  float halfSide = side/2;
  fill(250, 200, 200);
  rectMode(CENTER);
  translate(0, 0, -halfSide);
  noStroke();
  rect(0, 0, side, side);
  translate(0, 0, halfSide);

  //draw dots inside box
  stroke(pointColor);
  strokeWeight(pointSize);
  for (int i = 0; i < numPoints; ++i) {
    float x = random(-halfSide, halfSide);
    float y = random(-halfSide, halfSide);
    float z = random(-halfSide, halfSide);
    point(x, y, z);
  }

  //draw box frame
  noFill();
  stroke(100, 100);
  box(side, side, side);
}


