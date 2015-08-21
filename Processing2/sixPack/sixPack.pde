import processing.pdf.*;  //<>//

float PPI = 72; 
float canDiameter = 2.6 * PPI;
float canEdgeToPackageEdge = 0.5 * PPI;
float canEdgeToPackageCenter = 0.5 * PPI;
float edgeBuffer = 5;
float thickness = 0.128 * PPI;
float tabLength = 0.5 * PPI;
float tabExtensionHeight = 0.5 * PPI;
float tabExtensionRadius = tabExtensionHeight * 0.5;
float nutWidth = 5.0/16 * PPI;
float nutThickness = 0.125 * PPI;
float boltLength = 0.48 * PPI;
float boltDiameter = 0.146 * PPI;
float innerBoltInsetFromCenter = 0.75 * PPI;
float handleHeight = 5 * PPI;
float sideSupportWidth = 1.0 * PPI;
float sideSupportHeight = 4.5 * PPI;//from ground to surface of top horizontal surface
float sideSupportTopGap = sideSupportHeight * 0.75;
float canHolderPlatformSeparation = sideSupportTopGap - thickness;
float elevationFromBottom = 0.25 * PPI;
int numberBaseHoles = 4;

//derived
float packageWidth = (canDiameter + canEdgeToPackageEdge + canEdgeToPackageCenter) * 2;
float packageLength = canDiameter * 3 + canEdgeToPackageEdge * 4;
float packageHeight = handleHeight + sideSupportHeight;
float can1CenterX  = canEdgeToPackageEdge + canDiameter * 0.5;
float can1CenterY  = can1CenterX;
float can2CenterX  = packageWidth - can1CenterX;
float can2CenterY = can1CenterY + canEdgeToPackageEdge + canDiameter;
float can3CenterY = can2CenterY + canEdgeToPackageEdge + canDiameter;
float handleSlotLength = can3CenterY - can1CenterY;
float divider1Y = (can1CenterY + can2CenterY) * 0.5;
float divider2Y = (can2CenterY + can3CenterY) * 0.5;
float baseHoleSeparation = handleSlotLength / (numberBaseHoles + 1);
float baseHoleLength = baseHoleSeparation * 0.4;
float handleBottomTabLength = sideSupportHeight - sideSupportTopGap - 2 * thickness;

void setup() {
  size(72 * 24, 72 * 12);

  pushMatrix();
  startRecording("sixPack_sheet1");
  drawTop();
  translate( (int) packageWidth, 0);
  drawTop();
  translate( (int) packageWidth, 0);
  drawBottom();
  translate( (int) packageWidth + 1, 0);
  drawSideSupportWithUpperExtension();
  translate( (int) sideSupportWidth + 1, 0);
  drawSideSupportWithUpperExtension();
  translate( (int) -sideSupportWidth -1, sideSupportHeight + tabExtensionHeight);
  drawSideSupportWithUpperExtension();
  translate( (int) sideSupportWidth + 1, 0);
  drawSideSupportWithUpperExtension();

  //draw cutoff line to provide a 24 inch usable scrap
  popMatrix();
  float cutoffX = 3 * packageWidth + edgeBuffer;
  line(0, packageLength+edgeBuffer, cutoffX, packageLength+edgeBuffer);
  line(cutoffX + 2 * sideSupportWidth, packageLength+edgeBuffer, 24*PPI + edgeBuffer, packageLength+edgeBuffer);
  pushMatrix();
  stopRecording();

  startRecording("sixPack_sheet2");
   cutoffX = handleSlotLength+2*sideSupportTopGap+thickness;
  line(cutoffX, -edgeBuffer, cutoffX, 12 * 72-edgeBuffer);
  pushMatrix();
  translate( sideSupportTopGap - (packageLength - handleSlotLength - thickness)/2, packageWidth - handleHeight);
  drawHandle();
  popMatrix();
  rotate(PI/2);
  translate(0, -sideSupportTopGap);
  drawRib();
  translate(0, - (handleSlotLength + sideSupportTopGap + thickness));
  drawRib();

  translate(0, sideSupportTopGap );
  drawSideSupportWithUpperExtension();
  translate(sideSupportWidth, 0 );
  drawSideSupportWithUpperExtension();

  stopRecording();
}

void startRecording(String fileName) {
  pushMatrix();
  beginRecord(PDF, "pdf/"+fileName+".pdf"); 
  translate(edgeBuffer, edgeBuffer);//move away from upper corner 
  strokeWeight(0.072);
  background(255);
  noFill();
  background(255);
}

void stopRecording() {
  endRecord(); 
  popMatrix();
}


void drawHandle() {
  float canRadius = canDiameter * 0.5;
  float leftHandleEdgeX = packageLength/2 - handleSlotLength/2;
  float rightHandleEdgeX = packageLength/2 + handleSlotLength/2;
  float leftHandleArcCenterX = leftHandleEdgeX + canRadius;
  float rightHandleArcCenterX = packageLength/2 + handleSlotLength/2 - canRadius;
  arc(leftHandleArcCenterX, canRadius, canDiameter, canDiameter, PI, 3 * PI /2, OPEN);
  line(leftHandleArcCenterX, 0, rightHandleArcCenterX, 0);
  arc(rightHandleArcCenterX, canRadius, canDiameter, canDiameter, -HALF_PI, 0, OPEN);
  beginShape();
  //starting bottom of curved handle on left. drawing counterclockwise
  vertex(leftHandleEdgeX, canRadius);
  vertex(leftHandleEdgeX, handleHeight);
  vertex(thickness, handleHeight);
  float yTabStart = topYTabRib();
  vertex(thickness, handleHeight + yTabStart);
  //top tab on left
  vertex(0, handleHeight + yTabStart);
  vertex(0, handleHeight + yTabStart+thickness);
  vertex(thickness, handleHeight + yTabStart+thickness);
  yTabStart = topYTabRib();
  vertex(thickness, handleHeight + yTabStart+thickness);
  yTabStart = bottomYTabRib();
  //bottom tab on left
  vertex(thickness, handleHeight + yTabStart);
  vertex(0, handleHeight + yTabStart);
  vertex(0, handleHeight + yTabStart+thickness);
  vertex(thickness, handleHeight + yTabStart+thickness);
  float y = handleHeight + sideSupportTopGap;
  vertex(thickness, y);
  vertex(leftHandleEdgeX, y);
  y = handleHeight + sideSupportHeight - elevationFromBottom - thickness * 2;
  vertex(leftHandleEdgeX, y);

  //bottom tabs in center
  float yBottom = sideSupportHeight + handleHeight - thickness;//hmmm. not sure why thickness is needed
  for (int i = numberBaseHoles - 1; i >= 0; --i) {
    float x = packageLength/2 - (i - numberBaseHoles/2 + 0.5) * baseHoleSeparation;
    vertex(x - baseHoleLength/2, y);
    vertex(x - baseHoleLength/2, yBottom);
    vertex(x + baseHoleLength/2, yBottom);
    vertex(x + baseHoleLength/2, y);
  }

  vertex(rightHandleEdgeX, y);
  y = handleHeight + thickness + sideSupportTopGap;
  vertex(rightHandleEdgeX, y);
  vertex(packageLength - thickness, y);
  vertex(packageLength - thickness, handleHeight + yTabStart+thickness);
  vertex(packageLength, handleHeight + yTabStart+thickness);
  vertex(packageLength, handleHeight + yTabStart);
  vertex(packageLength - thickness, handleHeight + yTabStart);
  yTabStart = topYTabRib();
  vertex(packageLength - thickness, handleHeight + yTabStart +thickness);
  vertex(packageLength, handleHeight + yTabStart +thickness);
  vertex(packageLength, handleHeight + yTabStart );
  vertex(packageLength - thickness, handleHeight + yTabStart);
  vertex(packageLength - thickness, handleHeight);
  vertex(rightHandleEdgeX, handleHeight);
  vertex(rightHandleEdgeX, canRadius);
  endShape();
  pushMatrix();
  translate(thickness, handleHeight + sideSupportTopGap/2);
  rotate(PI/2);
  drawTSlot();
  popMatrix();
  pushMatrix();
  translate(packageLength - thickness, handleHeight + sideSupportTopGap/2);
  rotate(-PI/2);
  drawTSlot();
  popMatrix();
  y = handleHeight + sideSupportHeight - elevationFromBottom - thickness * 2;
  for (int i = 1; i < numberBaseHoles; ++i) {
    pushMatrix();
    float x = packageLength/2 - (i - numberBaseHoles/2) * baseHoleSeparation * 2;
    translate(x, y);
    drawTSlot();
    popMatrix();
  }

  rectMode(CENTER);
  float handleLength = handleSlotLength * 0.7;
  rectWithCircularCorners((packageLength - handleLength)/2, canRadius*0.5, handleLength, handleLength/4, handleLength/8);

  //slots for ribs
  float yCenter = handleHeight + sideSupportTopGap/2;
  rect(divider1Y, yCenter, thickness, sideSupportTopGap);
  rect(divider2Y, yCenter, thickness, sideSupportTopGap);
}

float topYTabRib() {
  return sideSupportTopGap * 0.25 -thickness/2;
}

float bottomYTabRib() {
  return sideSupportTopGap * 0.75 -thickness/2;
}

void drawRib() {
  //  rect(0,0,packageWidth - thickness*2, canHolderPlatformSeparation);
  beginShape();
  vertex(thickness, 0);
  vertex(packageWidth - thickness, 0);
  float yTabStart = topYTabRib();
  vertex(packageWidth - thickness, yTabStart);
  vertex(packageWidth, yTabStart);
  vertex(packageWidth, yTabStart + thickness);
  vertex(packageWidth - thickness, yTabStart + thickness);
  yTabStart = bottomYTabRib();
  vertex(packageWidth - thickness, yTabStart );
  vertex(packageWidth, yTabStart);
  vertex(packageWidth, yTabStart + thickness);
  vertex(packageWidth - thickness, yTabStart + thickness);
  vertex(packageWidth - thickness, sideSupportTopGap);
  vertex(thickness, sideSupportTopGap);
  vertex( thickness, yTabStart + thickness);
  vertex(0, yTabStart + thickness);
  vertex(0, yTabStart);
  vertex(thickness, yTabStart );
  vertex(thickness, yTabStart );
  yTabStart = topYTabRib();
  vertex(thickness, yTabStart + thickness);
  vertex(0, yTabStart + thickness);
  vertex(0, yTabStart);
  vertex(thickness, yTabStart);
  vertex(thickness, 0);
  endShape();
  pushMatrix();
  translate(thickness, sideSupportTopGap/2);
  rotate(PI/2);
  drawTSlot();
  popMatrix();
  pushMatrix();
  translate(packageWidth - thickness, sideSupportTopGap/2);
  rotate(-PI/2);
  drawTSlot();
  popMatrix();
}

void drawSideSupportWithUpperExtension() {
  partialRectWithUpperCircularCorners(0, 0, sideSupportWidth, tabExtensionHeight, tabExtensionRadius);
  float tabInset = (sideSupportWidth - tabLength) / 2;
  pushMatrix();
  translate(0, tabExtensionHeight);
  beginShape();
  vertex(sideSupportWidth, 0);
  vertex(sideSupportWidth - tabInset, 0);
  vertex(sideSupportWidth - tabInset, thickness);
  vertex(sideSupportWidth, thickness);
  vertex(sideSupportWidth, thickness + sideSupportTopGap);
  vertex(sideSupportWidth - tabInset, thickness + sideSupportTopGap);
  vertex(sideSupportWidth - tabInset, 2*thickness + sideSupportTopGap);
  vertex(sideSupportWidth, 2*thickness + sideSupportTopGap);
  vertex(sideSupportWidth, sideSupportHeight - elevationFromBottom - thickness);
  vertex(sideSupportWidth - tabInset, sideSupportHeight - elevationFromBottom - thickness);
  vertex(sideSupportWidth - tabInset, sideSupportHeight - elevationFromBottom);
  vertex(sideSupportWidth, sideSupportHeight - elevationFromBottom);
  vertex(sideSupportWidth, sideSupportHeight);
  vertex(0, sideSupportHeight);
  vertex(0, sideSupportHeight - elevationFromBottom);
  vertex(tabInset, sideSupportHeight - elevationFromBottom);
  vertex(tabInset, sideSupportHeight - elevationFromBottom - thickness);
  vertex(0, sideSupportHeight - elevationFromBottom - thickness);
  vertex(0, 2*thickness + sideSupportTopGap);
  vertex(tabInset, 2*thickness + sideSupportTopGap);
  vertex(tabInset, thickness + sideSupportTopGap);
  vertex(0, thickness + sideSupportTopGap);
  vertex(0, thickness);
  vertex(tabInset, thickness);
  vertex(tabInset, 0);
  vertex(0, 0);
  endShape();

  //bolt hole
  ellipse(sideSupportWidth/2
    , thickness + sideSupportTopGap/2
    , boltDiameter, boltDiameter);

  //alignment holes
  rectMode(CENTER);
  rect(sideSupportWidth/2, thickness + sideSupportTopGap * 0.25, thickness, thickness);
  rect(sideSupportWidth/2, thickness + sideSupportTopGap * 0.75, thickness, thickness);

  //  rect(sideSupportWidth/2 , thickness /2 , thickness, thickness);
  //  rect(sideSupportWidth/2, (thickness * 3 + sideSupportTopGap)/4, thickness, thickness);
  //  rect(sideSupportWidth/2, (thickness * 5 + sideSupportTopGap * 3) /4, thickness, thickness);
  //  rect(sideSupportWidth/2 , thickness * 3 / 2  + sideSupportTopGap, thickness, thickness);
  popMatrix();
}

void drawSideSupportOriginal() {
  float tabInset = (sideSupportWidth - tabLength) / 2;
  beginShape();
  vertex(0, thickness);
  vertex(tabInset, thickness);
  vertex(tabInset, 0);
  vertex(tabInset + tabLength, 0);
  vertex(tabInset + tabLength, thickness);
  vertex(sideSupportWidth, thickness);
  vertex(sideSupportWidth, thickness + sideSupportTopGap);
  vertex(sideSupportWidth - tabInset, thickness + sideSupportTopGap);
  vertex(sideSupportWidth - tabInset, 2*thickness + sideSupportTopGap);
  vertex(sideSupportWidth, 2*thickness + sideSupportTopGap);
  vertex(sideSupportWidth, sideSupportHeight - elevationFromBottom - thickness);
  vertex(sideSupportWidth - tabInset, sideSupportHeight - elevationFromBottom - thickness);
  vertex(sideSupportWidth - tabInset, sideSupportHeight - elevationFromBottom);
  vertex(sideSupportWidth, sideSupportHeight - elevationFromBottom);
  vertex(sideSupportWidth, sideSupportHeight);
  vertex(0, sideSupportHeight);
  vertex(0, sideSupportHeight - elevationFromBottom);
  vertex(tabInset, sideSupportHeight - elevationFromBottom);
  vertex(tabInset, sideSupportHeight - elevationFromBottom - thickness);
  vertex(0, sideSupportHeight - elevationFromBottom - thickness);
  vertex(0, 2*thickness + sideSupportTopGap);
  vertex(tabInset, 2*thickness + sideSupportTopGap);
  vertex(tabInset, thickness + sideSupportTopGap);
  vertex(0, thickness + sideSupportTopGap);
  vertex(0, thickness);
  endShape();
}

void drawTop() {
  rectWithCircularCorners(0, 0, packageWidth, packageLength, can1CenterX);//outline
  ellipse(can1CenterX, can1CenterY, canDiameter, canDiameter);//can
  ellipse(can2CenterX, can1CenterY, canDiameter, canDiameter);//can
  ellipse(can1CenterX, can2CenterY, canDiameter, canDiameter);//can
  ellipse(can2CenterX, can2CenterY, canDiameter, canDiameter);//can
  ellipse(can1CenterX, can3CenterY, canDiameter, canDiameter);//can
  ellipse(can2CenterX, can3CenterY, canDiameter, canDiameter);//can

  drawTabsInEdge();

  //center slot
  rectMode(CENTER);
  rect(packageWidth/2, packageLength/2, thickness, handleSlotLength);

  //
  //  rect((packageWidth-tabLength)*0.5, 0, tabLength, thickness);//top
  //  rect((packageWidth-tabLength)*0.5, packageLength - thickness, tabLength, thickness);//bottom

  //bolt holes
  //  ellipse(packageWidth/2 - innerBoltInsetFromCenter, divider1Y, boltDiameter, boltDiameter);
  //  ellipse(packageWidth/2 + innerBoltInsetFromCenter, divider1Y, boltDiameter, boltDiameter);
  //  ellipse(packageWidth/2 - innerBoltInsetFromCenter, divider2Y, boltDiameter, boltDiameter);
  //  ellipse(packageWidth/2 + innerBoltInsetFromCenter, divider2Y, boltDiameter, boltDiameter);
}

void drawTabsInEdge() {
  rectMode(CORNER);
  rect(0, divider1Y - tabLength * 0.5, thickness, tabLength);//left top
  rect(packageWidth - thickness, divider1Y - tabLength * 0.5, thickness, tabLength);//right top
  rect(0, divider2Y - tabLength * 0.5, thickness, tabLength);//left bottom
  rect(packageWidth - thickness, divider2Y - tabLength * 0.5, thickness, tabLength);//right bottom
  rect((packageWidth-tabLength)*0.5, 0, tabLength, thickness);//top
  rect((packageWidth-tabLength)*0.5, packageLength - thickness, tabLength, thickness);//bottom
}

void drawBottom() {
  rectWithCircularCorners(0, 0, packageWidth, packageLength, can1CenterX);//outline

  drawTabsInEdge();

  //base holes
  rectMode(CENTER);
  for (int i = 0; i < numberBaseHoles; ++i) {
    rect(packageWidth/2, packageLength/2 - (i - numberBaseHoles/2 + 0.5) * baseHoleSeparation, thickness, baseHoleLength);
  }
  for (int i = 1; i < numberBaseHoles; ++i) {
    ellipse(packageWidth/2, packageLength/2 - (i - numberBaseHoles/2) * baseHoleSeparation * 2, boltDiameter, boltDiameter);
  }
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
