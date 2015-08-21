import processing.dxf.*;

ArrayList<NeighborPixel> neighbors;
int WHITE = color(255);
int BLACK = color(0);
float PIXELS_PER_INCH = 72;
String dxfFileName;
float widthInInches;
boolean needsRedraw = false;

void setup() {
  //High resolution of the bitmap version is needed 
  //if our vector-based drawing is to look smooth.
  int size = 1000;
  size(size, size, P2D);
  initializeEdgeCalculator();
  background(255);
  noSmooth();

  float strkWeight = 12.0 * width / 480;
  float distanceToEllipseCenter = -0.16;//0.35 fills center
  float ellipseRotation = 38;
  float ellipseWidth = 0.35;
  float  heightFactor = 0.19;
  int n = 18;
  drawEllipses2( strkWeight, distanceToEllipseCenter, ellipseRotation, ellipseWidth, heightFactor, n);
  createEdgeOnlyDXF("ellipses_12_n016_38_035_019_18.dxf", 72*12);
 }


void draw() {
  if (!needsRedraw) return;
  needsRedraw = false;
}


void keyPressed() {
  println("keyPressed = "+key);
  if (key == 'w') {
    createEdgeOnlyDXF(dxfFileName, widthInInches * PIXELS_PER_INCH);
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

void createEdgeOnlyDXF(String filename, float pixelWidth) {
  loadPixels();
  EdgeCalculator ec = new EdgeCalculator();
  //  ec.blackenAnyNonWhite();
  ec.removeNonEdgePixels();
  ec.removeExtraNeighbors();
  ec.buildVectors();
  //heuristic...
  float maxError = 1;
  ec.reduceVectors(maxError);
  updatePixels();

  beginRaw(DXF, "dxf/"+filename);
  float strokeWt = 0.005;
  float scale = pixelWidth / width;
  ec.drawDXFVectors(strokeWt, scale);
  endRaw();
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
