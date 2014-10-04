import processing.pdf.*;

ArrayList<NeighborPixel> neighbors;
int WHITE = color(255);

void setup() {
  //High resolution of the bitmap version is needed 
  //if our vector-based drawing is to look smooth.
  size(500, 500);
  createNeighborPixels();
  background(255);
  noSmooth();

  //  exampleLissajous();
  //  generatePDF("exampleLissajous.pdf");

  //  exampleMobileSpar();
  //  generatePDF("exampleMobileSpar.pdf");

  exampleFromFile();
  generatePDF("exampleSnowflake.pdf");


  //  float angleScale = 1.1;
  //  float angleShift = 0;
  //  exampleFractalTree(angleScale, angleShift);
  //  generatePDF("exampleFractalTree.pdf");
}

void generatePDF(String filename) {
  loadPixels();
  EdgeCalculator ec = new EdgeCalculator();
  ec.removeNonEdgePixels();
  ec.removeExtraNeighbors();
  ec.buildVectors();
  //heuristic...
  float maxError = 1;
  ec.reduceVectors(maxError);
  updatePixels();

  //  beginRecord(PDF, filename);
  //  background(255);
  //  ec.drawVectors(0.072, 0.1);
  //  endRecord();

  //Now you can scale down the size. 
  PGraphics pdf = createGraphics(300, 300, PDF, filename);
  pdf.beginDraw();

  float strokeWt = 0.072;
  float scale = 0.5;
  ec.drawVectors(strokeWt, scale, pdf);

  pdf.dispose();
  pdf.endDraw();
}

void createNeighborPixels() {
  neighbors = new ArrayList<NeighborPixel>();
  neighbors.add(new NeighborPixel(0, -1));
  neighbors.add(new NeighborPixel(1, -1));
  neighbors.add(new NeighborPixel(1, 0));
  neighbors.add(new NeighborPixel(1, 1));
  neighbors.add(new NeighborPixel(0, 1));
  neighbors.add(new NeighborPixel(-1, 1));
  neighbors.add(new NeighborPixel(-1, 0));
  neighbors.add(new NeighborPixel(-1, -1));
}

void exampleLissajous() {
  pushMatrix();
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 2 * PI / numSteps * i;
    x = width * .45 * cos(15 * angle);
    y = height * .45 * cos(17 * angle);
    if (i>0) {
      float sw = 8000 / (500 + dist(x, y, 0, 0) / width * 800)* width/400;
      strokeWeight(sw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  popMatrix();
}

void exampleEllipse() {
  strokeWeight(width/5);
  ellipse(width/2, height/2, width /2, height/2);
}

void exampleFractalTree(float angleScale, float angleShift) {
  drawTree(width * 0.5f, height * 0.95f, width * 0.5f, height * 0.83f, 0, angleScale, angleShift);
}

private void drawTree(float x1, float y1, float x2, float y2, int level, float angleScale, float angleShift) {
  int maxLevel = 8;
  if (level > maxLevel) {
    return;
  }
  float rotation = PI * 0.125;
  float scaleDown = 0.85f;
  // draw the trunk of the tree
  //  stroke(level * level * 255.0f / maxLevel / maxLevel, 0, 0);
  stroke(0);
  float strokeWt = (maxLevel - level + 5) * width / 800;
  strokeWeight(strokeWt);
  line(x1, y1, x2, y2);

  // create two branches, each of which is another tree (recursion!)
  float angle = (rotation + angleShift) * angleScale;
  float cosR = cos(angle);
  float sinR = sin(angle);
  drawTree(x2, y2, 
  x2 + scaleDown * (cosR * (x2 - x1) - sinR * (y2 - y1)), y2
    + scaleDown * (sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1, angleScale, angleShift);
  angle = (rotation - angleShift) * angleScale;
  cosR = cos(angle);
  sinR = sin(angle);
  drawTree(x2, y2, 
  x2 + scaleDown * (cosR * (x2 - x1) + sinR * (y2 - y1)), y2
    + scaleDown * (-sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1, angleScale, angleShift);
}

void exampleMobileSpar() {
  background(255);
  noFill();
  translate(width/2, height/2);
  int numCircles = 30;
  float maxRadius = width / 8;
  float curvatureScalar = 0.12;
  float curveScalar = 3;
  float strokeWtScale = 0.35;
  float separationScale = 1;
  float x = -width/2 * 0.9;
  float y = 0;

  for (int i = 1; i <= numCircles; ++i ) {
    float radius = abs(maxRadius * sin((i + 5) * 0.01));
    float dx = radius * separationScale;
    x += dx ;
    y -= curveScalar * curvatureScalar * sin(i * curvatureScalar) * dx ;
    strokeWeight(radius * strokeWtScale);
    ellipse(x, y, 2 * radius, 2 * radius);
  }
}

void exampleFromFile() {
  PImage img;
  img = loadImage("snowflake43.png");
  image(img, 0, 0);
}
