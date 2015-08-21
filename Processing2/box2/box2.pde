import processing.pdf.*; 

float PPI = 72; 
float boxWidth = 17 * PPI;
float boxDepth = 23 * PPI;
float boxHeight = 16 * PPI;
float tabLength = 2 * PPI;
float edgeBuffer = 0.55 * PPI;
//float frontVerticalTabHeight = 0.25 * PPI;

float strokeWt = 0.072;

//material specs
float thickness = 0.5 * PPI; //per calipers //3.0 / 32 * PPI;
float boltDiameter = 0.25 * PPI;
//derived
float tabInset = thickness;

void setup() {
  size(72 * 18, 72 * 25);

  startRecording("box_front");
  drawFront();
  stopRecording();
  //
  //  startRecording("box_side");
  //  drawSide();
  //  stopRecording();
  //
  //  startRecording("box_bottom");
  //  drawBottomPanel();
  //  stopRecording();
}

void drawFront() {

  float lengthSoFar = 0;
  boolean done = false;
  while (!done) {
    float nextLength = lengthSoFar + tabLength;
    if (nextLength > boxWidth) {
      nextLength = boxWidth;
      done = true;
    }
    line(lengthSoFar, 0, nextLength, 0);
    if (!done) {
      line(nextLength, 0, nextLength, thickness);
      float lastLength = nextLength + tabLength;
      if (lastLength > boxWidth) {
        lastLength = boxWidth;
        done = true;
      }
      line(nextLength, thickness, lastLength, thickness);
      line(lastLength, thickness, lastLength, 0);
      lengthSoFar = lastLength;
    }
  }
}

//Utilities
void startRecording(String fileName) {
  pushMatrix();
  beginRecord(PDF, "pdf/"+fileName+".pdf"); 
  translate(edgeBuffer, edgeBuffer);//move away from upper corner 
  strokeWeight(strokeWt);
  background(255);
  noFill();
  background(255);
}

void stopRecording() {
  endRecord();
}
