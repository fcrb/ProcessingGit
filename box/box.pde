import processing.pdf.*; 

float PPI = 72; 
float boxFrontWidth = 9.125 * PPI;
float boxSideLength = 11.25 * PPI;
float boxHeight = 2.375 * PPI;
float edgeBuffer = 5;
float frontVerticalTabHeight = 0.25 * PPI;
float strokeWt = 0.072;

//material specs
float thickness = 0.814 / 8 * PPI; //per calipers //3.0 / 32 * PPI;
//... per http://bit.ly/1D6ckUy
float nutWidth = 1.0 / 4 * PPI;
float nutThickness = 3.0/32 * PPI;
float boltLength = 0.48 * PPI;
float boltDiameter = 0.146 * PPI;

//derived
float tabInset = thickness;

void setup() {
  size(72 * 12, 72 * 12);

  startRecording("box_front");
  drawFront();
  stopRecording();

  startRecording("box_side");
  drawSide();
  stopRecording();

  startRecording("box_bottom");
  drawBottomPanel();
  stopRecording();
}

float[] frontPanelBottomJoint() {
  int numHoles = round(boxFrontWidth / (thickness * 2))-3;
  float xStart = (boxFrontWidth - thickness * (numHoles * 2 - 1))/2;
  float fingerWidth = thickness;
  return fingersEvenlySpaced(boxFrontWidth, xStart, fingerWidth, numHoles);
}

float[] sidePanelBottomJoint() {
  return fingersEvenlySpaced(boxSideLength, boxSideLength/12, boxSideLength/12, 6);
}

void drawBottomPanel() {
  //where it fits into front panel
  pushMatrix();
  for (int i = 0; i < 2; ++i) {
    drawFingers(0, 0, thickness, frontPanelBottomJoint(), boxFrontWidth, 0);
    translate(boxFrontWidth - thickness * 2, 0);
    pushMatrix();
  translate(thickness, boxSideLength/2);
  rotate(3 * PI/2);
    drawTSlot();
    popMatrix();

    drawFingers(0, 0, thickness, sidePanelBottomJoint(), boxSideLength, PI / 2);
    translate(thickness * 2, boxSideLength);
    rotate(PI );
  }
  popMatrix();
}

void drawSide() {
  //outline
  float[] verticalFingers = fingersEvenlySpaced(boxHeight, frontVerticalTabHeight/2, frontVerticalTabHeight, 4);
  for (int i = 0; i < 2; ++i) {
    pushMatrix();
    translate(0, boxHeight/2);
    rotate(PI/2);
    drawTSlot();
    popMatrix();
    drawFingers(thickness, 0, -thickness, verticalFingers, boxHeight, PI/2);
    line(thickness, boxHeight, boxSideLength + thickness, boxHeight);
    translate(boxSideLength + thickness * 2, boxHeight);
    rotate(PI);
  }

  //horizontal
  pushMatrix();
  ellipse(boxSideLength/2 + thickness, boxHeight - thickness * 1.5, boltDiameter, boltDiameter);
  translate(thickness, boxHeight - thickness * 2);
  drawFingerSlots(sidePanelBottomJoint());
  popMatrix();
}

void drawFront() {
  // bolt holes
  ellipse(thickness * 1.5, boxHeight/2, boltDiameter, boltDiameter);
  ellipse(boxFrontWidth - thickness * 1.5, boxHeight/2, boltDiameter, boltDiameter);

  //vertical sides
  float[] verticalSlots = fingersEvenlySpaced(boxHeight, frontVerticalTabHeight/2, frontVerticalTabHeight, 4);
  pushMatrix();
  translate(thickness * 2, 0);
  rotate(PI/2);
  drawFingerSlots(verticalSlots);
  popMatrix();
  pushMatrix();
  translate(boxFrontWidth - thickness, 0);
  rotate(PI/2);
  drawFingerSlots(verticalSlots);
  popMatrix();

  //holes along bottom
  pushMatrix();
  translate(0, boxHeight - thickness * 2);
  drawFingerSlots(frontPanelBottomJoint());
  popMatrix();

  //outline
  rect(0, 0, boxFrontWidth, boxHeight);//outline
}

void drawTSlot() {
  //center of bottom of T at 0,0, vertical orientation
  beginShape();
  vertex(-boltDiameter/2, 0);
  float slotLength =  boltLength - nutThickness;//account for nut on other side
  vertex(-boltDiameter/2, -slotLength);
  vertex(-nutWidth/2, -slotLength);
  vertex(-nutWidth/2, -boltLength);
  vertex(nutWidth/2, -boltLength);
  vertex(nutWidth/2, -slotLength);
  vertex(boltDiameter/2, -slotLength);
  vertex(boltDiameter/2, 0);
  endShape();
}

//Utilities

void rectWithCircularCorners(float x, float y, float w, float h, float r) {
  arc(x+r, y+r, r*2, r*2, PI, PI * 1.5); 
  line(x+r, y, x+w-r, y);
  arc( x+w-r, y+r, r*2, r*2, PI*1.5, TWO_PI); 
  line(x+w, y+r, x+w, y+h-r);
  arc( x+w-r, y+h-r, r*2, r*2, 0, PI * 0.5); 
  line(x+w-r, y+h, x+r, y+h);
  arc( x+r, y+h-r, r*2, r*2, PI * 0.5, PI); 
  line(x, y+h-r, x, y+r);
}

void partialRectWithUpperCircularCorners(float x, float y, float w, float h, float r) {
  line(x, y+h, x, y+r);
  arc(x+r, y+r, r*2, r*2, PI, PI * 1.5); 
  line(x+r, y, x+w-r, y);
  arc( x+w-r, y+r, r*2, r*2, PI*1.5, TWO_PI); 
  line(x+w, y+r, x+w, y+h);
  //  arc( x+w-r, y+h-r, r*2, r*2, 0, PI * 0.5); 
  //  line(x+w, y+h, x, y+h);
  //  arc( x+r, y+h-r, r*2, r*2, PI * 0.5, PI);
}  


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

float[] fingersEvenlySpaced(float sideLength, float firstFingerStart, float fingerWidth, int numFingers) {
  // Return an array that begins with coordinate of edge of first finger,
  //      followed by coordinate of other edge of finger
  float[] fingers = new float[numFingers * 2];
  float centersBetweenFingers = (sideLength - firstFingerStart * 2 - fingerWidth)/(numFingers - 1);
  for (int i = 0; i < numFingers; ++i) {
    int fingerIndex = 2 * i;
    fingers[fingerIndex] = firstFingerStart + i * centersBetweenFingers;
    fingers[fingerIndex+1] = fingers[fingerIndex] + fingerWidth;
  }
  return fingers;
}

void drawFingers(float x0, float y0, float fingerDepth, float[] fingers, float sideLength, float rotation) {
  //
  pushMatrix();
  translate(x0, y0);
  rotate(rotation);
  int numFingers = fingers.length/2;
  beginShape();
  vertex(0, 0);
  for (int i = 0; i < numFingers; ++i) {
    int fingerIndex = 2 * i;
    vertex(fingers[fingerIndex], 0);
    vertex(fingers[fingerIndex], -fingerDepth);
    vertex(fingers[fingerIndex+1], -fingerDepth);
    vertex(fingers[fingerIndex+1], 0);
  }
  vertex(sideLength, 0);
  endShape();
  popMatrix();
}

void drawFingerSlots(float[] fingers) {
  int numFingers = fingers.length/2;
  for (int i = 0; i < numFingers; ++i) {
    int fingerIndex = 2 * i;
    rect(fingers[fingerIndex], 0, fingers[fingerIndex+1]-fingers[fingerIndex], thickness);
  }
}
