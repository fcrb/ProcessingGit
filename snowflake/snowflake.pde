int SIZE = 150;
int DEPTH = 4;
float THICKNESS = 10;
float[] fractions = new float[DEPTH];
int[] angles = new int[DEPTH];
int saves = 0;
float flakeColor = 0;

void setup() {
  size(500,500);
  stroke(0);
  pushMatrix();
  strokeWeight(THICKNESS);
  fill(flakeColor);
  snowflake();
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    save("snowflake" + saves + ".png");
    saves = saves + 1;
  }
  snowflake();
}

void snowflake() {
  background(255 - flakeColor);
  translate(250,250);
  rotate(radians(-90));
  for(int i = 0; i<DEPTH; i++) {
    fractions[i] = 0.5 + 0.25*(random(1) - random(1));
    angles[i] = int(60 + random(40) - random(40));
  }
  for(int i = 0; i<6; i++) {
      branch(SIZE,0);
      rotate(radians(60));
  }
  strokeWeight(THICKNESS);
  ellipse(0,0,0.25*SIZE,0.25*SIZE);
  ellipse(SIZE,0,0.125*SIZE,0.125*SIZE);
  fill(255 - flakeColor);
  ellipse(SIZE,0,0.1*SIZE,0.1*SIZE);
}

void branch(int size, int depth) {
  if(depth<DEPTH) {
    hexLine(0,0,size,0, THICKNESS, int(flakeColor * ((float) depth / DEPTH)));
    branch(int(fractions[depth]*size),depth+1);
    pushMatrix();
    translate(fractions[depth]*size,0);
    branch(int(fractions[depth]*size),depth+1);
    pushMatrix();
    rotate(radians(-angles[depth]));
    branch(int(fractions[depth]*size),depth+1);
    popMatrix();
    pushMatrix();
    rotate(radians(angles[depth]));
    branch(int(fractions[depth]*size),depth+1);
    popMatrix();
    popMatrix();
  } 
}

void hexLine(float x0, float y0, float x1, float y1, float lineWidth, int clr) {
  pushMatrix();
  stroke(clr);
  fill(clr);
  strokeWeight(lineWidth);
  strokeCap(SQUARE);
  line(x0, y0, x1, y1);
  strokeWeight(.1);
  drawTip(x0, y0, x1, y1, lineWidth);
  drawTip(x1, y1, x0, y0, lineWidth);
  popMatrix();
}

void drawTip(float x0, float y0, float x1, float y1, float lineWidth) {
  beginShape();
  float lineLength = dist(x0, y0, x1, y1);
  float triHeight = lineWidth * 0.5 / sqrt(3);
  // altitude of cap
  float xTipDelta = (x1-x0) * triHeight / lineLength;
  float yTipDelta = (y1-y0) * triHeight / lineLength;
  vertex(x0 - xTipDelta, y0 - yTipDelta);
  // base vertices
  float xDelta = lineWidth * 0.5 * (y1 - y0) / lineLength;
  float yDelta = lineWidth * 0.5 * (x1 - x0) / lineLength;
  float eps = 0;
  vertex(x0 - xDelta + eps*(x1 - x0), y0 + yDelta + eps*(y1 - y0));
  vertex(x0 + xDelta, y0 - yDelta);
  endShape(CLOSE);
}



void draw() {
}
