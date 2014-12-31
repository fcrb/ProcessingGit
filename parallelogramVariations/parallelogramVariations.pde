import processing.pdf.*;

//constant values
float widthInInches = 24;
float heightInInches = 12;
float sideLengthInInches = 1.0;
float PPI = 72;//scalar to convert inches to pixels

//derived values
float sideLengthInPixels = sideLengthInInches * PPI;
float rowSeparation = sideLengthInPixels /2 * sqrt(3);

//globals
float x = -sideLengthInPixels * 0.9;
float y = -sideLengthInPixels * 0.52;

void setup() {
  // *********** Specify your DrawSegment here **********
//  float angleInDegrees = 55;  
//  DrawSegment segmentFunctor = new ZigZagSegment(angleInDegrees * PI / 180);
//  String fileName = "parallelogramZigZag_"+angleInDegrees+"degrees";

  DrawSegment segmentFunctor = sineSegment;
  String fileName = "parallelogramSine";

  size((int )(widthInInches * PPI), (int )(heightInInches * PPI));
  beginRecord(PDF, "pdf/"+fileName+".pdf"); 
  background(255);
  strokeWeight(0.072); 
  float initialX = x;
  while ( y < height) {
    boolean flip = false;
    while ( x < width + sideLengthInPixels) {
      drawOriented(flip, false, segmentFunctor);
      drawOriented(flip, true, segmentFunctor);
      flip = !flip;
      x += sideLengthInPixels;
    }
    initialX += sideLengthInPixels/2;
    if (initialX > 0 ) {
      initialX -= 2 * sideLengthInPixels;
    }
    x = initialX;
    y += rowSeparation;
  }
  endRecord();
}

void drawOriented(boolean flip, boolean rotate, DrawSegment segFunctor) {
  pushMatrix();
  translate(x, y);
  if (rotate) {
    rotate(-4*PI/3);
  }   
  if (flip) {
    scale(1, -1);
  }
  segFunctor.drawSegment();
  popMatrix();
}
