import processing.pdf.*;

ArrayList<NeighborPixel> neighbors;
int WHITE = color(255);

void setup() {
  //High resolution of the bitmap version is needed 
  //if our vector-based drawing is to look smooth.
  size(8000, 8000);
  createNeighborPixels();
  background(255);
  noSmooth();

  //  ellipseExample();
  ellipseExample();

  generatePDF("edgeFinderDemo.pdf");
}

void generatePDF(String filename) {
  loadPixels();
  EdgeCalculator ec = new EdgeCalculator();
  ec.removeNonEdgePixels();
  ec.removeExtraNeighbors();
  ec.buildVectors();
  updatePixels();

  //  beginRecord(PDF, filename);
  //  background(255);
  //  ec.drawVectors(0.072, 0.1);
  //  endRecord();
  
  //Now you can scale down the size. 
  PGraphics pdf = createGraphics(800, 800, PDF, filename);
  pdf.beginDraw();
  
  float strokeWt = 0.072;
  float scale = 0.1;
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

void complexExample() {
  pushMatrix();
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 2 * PI / numSteps * i;
    x = width * .45 * cos(28 * angle);
    y = height * .45 * cos(19 * angle);
    if (i>0) {
      float sw = 6000 / (100 + dist(x, y, 0, 0) / width * 800)* width/800;
      strokeWeight(sw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  popMatrix();
}

void ellipseExample() {
  strokeWeight(width/5);
  ellipse(width/2, height/2, width /2, height/2);
}

