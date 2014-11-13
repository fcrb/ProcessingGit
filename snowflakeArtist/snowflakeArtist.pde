import processing.pdf.*;

ArrayList<NeighborPixel> neighbors;
int WHITE = color(255);
int BLACK = color(0);
float PIXELS_PER_INCH = 72;
String pdfFileName;
float widthInInches;
boolean needsRedraw = false;

int SYMMETRY = 6;
int penWidth = 5;
float xOld, yOld;
boolean drawingInProgress = false;
int imageCounter = 100;

void setup() {
  size(800, 800);
  background(255);
  stroke(0);
  strokeWeight(penWidth);
  strokeCap(ROUND);
  fill(0);
  initializeEdgeCalculator();
  background(255);
  noSmooth();
}

void keyPressed() {
  if (key == 'c') {
    background(255);
    return;
  }   
  if (key == 's') {
    save("snowflake"+(imageCounter++)+".png" );
    return;
  }   

  if (key == 'p') {
    createEdgeOnlyPDF("snowflake"+(imageCounter++)+".pdf", 72*12);
    return;
  }   

  char[] keyCodes = new char[] {
    '1', '2', '3', '4', '5', '6', '7', '8', '9'
  };
  for (int i = 0; i < keyCodes.length; ++i) {

    if (key == keyCodes[i]) {
      setPenWidth(5*(i+3));
    }
  }
}

void setPenWidth(int w) {
  penWidth = w;
  strokeWeight(penWidth);
}

void eraseDrawing() {
  background(255);
}

void draw() {
  if (!mousePressed ) {
    drawingInProgress = false;
    return;
  } 
  translate(width/2, height/2);
  float x = mouseX  - width/2;
  float y = mouseY  - height/2;
  if (!drawingInProgress) {
    xOld = x;
    yOld = y;
    drawingInProgress = true;
  }
  //disallow drawing outside the diameter of drawing area
  if (dist(x, y, 0, 0) > width * 0.48) return;
  for (int i = 0; i < SYMMETRY; ++i) {
    rotate(2 * PI /  SYMMETRY);
    line(xOld, yOld, x, y);
    line(-xOld, yOld, -x, y);
  }
  xOld = x;
  yOld = y;
}

void createEdgeOnlyPDF(String filename, float pixelWidth) {
  loadPixels();
  EdgeCalculator ec = new EdgeCalculator();
  ec.removeNonEdgePixels();
  ec.removeExtraNeighbors();
  ec.buildVectors();
  //heuristic...
  float maxError = 1;
  ec.reduceVectors(maxError);
  updatePixels();

  //Now you can scale down the size. 
  PGraphics pdf = createGraphics((int) pixelWidth, (int) pixelWidth, PDF, "pdf/"+filename);
  pdf.beginDraw();

  float strokeWt = 0.005;
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

