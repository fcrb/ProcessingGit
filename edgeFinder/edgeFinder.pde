ArrayList<NeighborPixel> neighbors;
//This is a hack that allows me, given a pair of 
//adjoining pixels, identify the index of the neighbor pixel
//where I should start looking for the next node in the 
//path
int[][] nextNeighborPixelIndex;
int ZERO_OFFSET = 1;
int WHITE = color(255);

void setup() {
  size(800, 800);
  neighbors = new ArrayList<NeighborPixel>();
  neighbors.add(new NeighborPixel(0, -1));
  neighbors.add(new NeighborPixel(1, -1));
  neighbors.add(new NeighborPixel(1, 0));
  neighbors.add(new NeighborPixel(1, 1));
  neighbors.add(new NeighborPixel(0, 1));
  neighbors.add(new NeighborPixel(-1, 1));
  neighbors.add(new NeighborPixel(-1, 0));
  neighbors.add(new NeighborPixel(-1, -1));

  nextNeighborPixelIndex = new int[3][3];
  //if direction to previous node is -1, -1, next node is top center (0).
  //But can't use negative indices, so add 1 to each array index:
  nextNeighborPixelIndex[-1 + ZERO_OFFSET][-1 + ZERO_OFFSET] = 0;
  nextNeighborPixelIndex[0 + ZERO_OFFSET][-1 + ZERO_OFFSET] = 1;
  nextNeighborPixelIndex[1 + ZERO_OFFSET][-1 + ZERO_OFFSET] = 2;
  nextNeighborPixelIndex[1 + ZERO_OFFSET][0 + ZERO_OFFSET] = 3;
  nextNeighborPixelIndex[1 + ZERO_OFFSET][1 + ZERO_OFFSET] = 4;
  nextNeighborPixelIndex[0 + ZERO_OFFSET][1 + ZERO_OFFSET] = 5;
  nextNeighborPixelIndex[-1 + ZERO_OFFSET][1 + ZERO_OFFSET] = 6;
  nextNeighborPixelIndex[-1 + ZERO_OFFSET][0 + ZERO_OFFSET] = 7;

  background(255);
  noSmooth();
  complexExample();

  loadPixels();
  EdgeCalculator ec = new EdgeCalculator();
  ec.removeNonEdgePixels();
  ec.removeExtraNeighbors();
  updatePixels();
}

void init() {
}

void complexExample() {
  translate(width/2, height/2);
  int numSteps = 100000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 2 * PI / numSteps * i;
    x = width * .45 * cos(28 * angle);
    y = height * .45 * cos(19 * angle);
    if (i>0) {
      float sw = 6000 / (100 + dist(x, y, 0, 0));
      strokeWeight(sw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
}

void ellipseExample() {
  strokeWeight(width/5);
  ellipse(width/2, height/2, width /2, height/2);
}
