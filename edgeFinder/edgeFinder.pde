import processing.pdf.*;

ArrayList<NeighborPixel> neighbors;
int WHITE = color(255);
int BLACK = color(0);
float PIXELS_PER_INCH = 72;
String pdfFileName;
float widthInInches;
boolean needsRedraw = false;

void setup() {
  //High resolution of the bitmap version is needed 
  //if our vector-based drawing is to look smooth.
  size(370, 372);
  initializeEdgeCalculator();
  background(255);
  noSmooth();

  //  pdfFileName = "exampleEllipses.pdf";
  //  exampleEllipses();
//  pdfFileName = "exampleRegularPolygonFractal.pdf";
//  exampleRegularPolygonFractal();
  //  pdfFileName = "exampleStarOfDavid.pdf";
  //  exampleStarOfDavid();
  // createEdgeOnlyPDF("starOfDavid_1_5in.pdf", 72*1.5);

  //  float strkWeight = 18 * width / 500;
  //  float distanceToEllipseCenter = 0.5;
  //  float ellipseRotation = 36;
  //  float ellipseWidth = 0.74;
  //  float h = 0.6;
  //  int n = 13;
  //  drawEllipses( strkWeight, distanceToEllipseCenter, ellipseRotation, ellipseWidth, h, n);
  //  createEdgeOnlyPDF("ellipses001_0_75in.pdf", 72*1.5);
  //  lissajous2(7,2,10);

  //  pdfFileName = "exampleLissajous.pdf";
  //  exampleLissajous();

  //  pdfFileName = "exampleMobileSpar.pdf";
  //  exampleMobileSpar();

  exampleFromFile("celticBraid.png");
  createEdgeOnlyPDF("celticBraid.pdf", 12*72);


  //  float angleScale = 1.1;
  //  float angleShift = 0;
  //  exampleFractalTree(angleScale, angleShift);
  //  createEdgeOnlyPDF("exampleFractalTree.pdf");
}


void draw() {
  if (!needsRedraw) return;
  needsRedraw = false;
}


void keyPressed() {
  println("keyPressed = "+key);
  if (key == 'w') {
    createEdgeOnlyPDF(pdfFileName, widthInInches * PIXELS_PER_INCH);
  }
  if (key == '+') {
    loadPixels();
    EdgeCalculator ec;
    ec = new EdgeCalculator();
    ec.addPixelLayer();
    updatePixels();
  }
  if (key == '-') {
    loadPixels();
    EdgeCalculator ec = new EdgeCalculator();
    ec.removePixelLayer();
    updatePixels();
  }
  needsRedraw = true;
}

void createEdgeOnlyPDF(String filename, float pixelWidth) {
  loadPixels();
  EdgeCalculator ec = new EdgeCalculator();
  ec.blackenAnyNonWhite();
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
  PGraphics pdf = createGraphics((int) pixelWidth, (int) pixelWidth, PDF, filename);
  pdf.beginDraw();

  float strokeWt = 0.072;
  float scale = pixelWidth / width;
  ec.drawVectors(strokeWt, scale, pdf);

  pdf.dispose();
  pdf.endDraw();
}

void initializeEdgeCalculator() {
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
