ArrayList<NeighborPixel> neighbors;
int WHITE = color(255);
int BLACK = color(0);
float PIXELS_PER_INCH = 72;
float maxError = 1;

void createEdgeOnlyPDF(String filename, float pixelWidth) {
  loadPixels();
  EdgeCalculator ec = new EdgeCalculator();
  ec.removeNonEdgePixels();
  ec.removeExtraNeighbors();
  ec.buildVectors();
  ec.reduceVectors(maxError);
  updatePixels();

  //Now you can scale down the size. 
  PGraphics pdf = createGraphics(1 +(int) pixelWidth, 1 + (int) (height * pixelWidth / width), PDF, "pdf/"+filename);
  pdf.beginDraw();

  float strokeWt = 0.02;
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

