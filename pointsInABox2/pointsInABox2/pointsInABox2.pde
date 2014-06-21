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
  float noiseStepSize = 0.005;
  for (int i = 0; i < numPoints; ++i) {
    float x = map(noise( i + frameCount * noiseStepSize), 0, 1, -halfSide, halfSide);
    float y = map(noise(10000 + i + frameCount * noiseStepSize * 0.83475), 0, 1, -halfSide, halfSide);
    float z = map(noise(30000 +  i + frameCount * noiseStepSize * 1.30911), 0, 1, -halfSide, halfSide);
    point(x, y, z);
  }

  //draw box frame
  noFill();
  stroke(100, 100);
  strokeWeight(1);
  box(side, side, side);
}


