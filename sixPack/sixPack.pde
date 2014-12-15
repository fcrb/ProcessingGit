float PPI = 72; //<>//
float canDiameter = 2.6 * PPI;
float canEdgeToPackageEdge = 0.5 * PPI;
float canEdgeToPackageCenter = 0.5 * PPI;
float edgeBuffer = 5;
float thickness = 0.128 * PPI;
float tabLength = 0.5 * PPI;
float tabExtensionHeight = 0.5 * PPI;
float tabExtensionRadius = tabExtensionHeight * 0.5;
float nutWidth = 5.0/16 * PPI;
float nutThickness = 0.1 * PPI;
float boltLength = 0.48 * PPI;
float boltDiameter = 0.115 * PPI;
float innerBoltInsetFromCenter = 0.75 * PPI;
float sideSupportWidth = 1.0 * PPI;
float sideSupportHeight = 4.5 * PPI;//from ground to surface of top horizontal surface
float sideSupportTopGap = sideSupportHeight * 0.75;
float canHolderPlatformSeparation = sideSupportTopGap - thickness;
float elevationFromBottom = 0.25 * PPI;
int numberBaseHoles = 4;

//derived
float packageWidth = (canDiameter + canEdgeToPackageEdge + canEdgeToPackageCenter) * 2;
float packageLength = canDiameter * 3 + canEdgeToPackageEdge * 4;
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

void setup() {
  size(72*10, 800);
  strokeWeight(0.25);
  background(255);
  noFill();
  translate(edgeBuffer, edgeBuffer);//move away from upper corner 
//    drawTop();
//  drawBottom();
// drawSideSupportWithUpperExtension();
  drawCenterSupport();
}

void drawCenterSupport() {
  rect(0,0,packageWidth - thickness*2, canHolderPlatformSeparation);
  beginShape();
  vertex(0,0);
  
  translate(0,canHolderPlatformSeparation/2);
  rotate(PI/2);
  drawTSlot();

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
  for (int i = 1; i < numberBaseHoles ; ++i) {
    ellipse(packageWidth/2, packageLength/2 - (i - numberBaseHoles/2) * baseHoleSeparation, boltDiameter, boltDiameter);
  }
}

void drawTSlot() {
  //center of bottom of T at 0,0, vertical orientation
  beginShape();
  vertex(-boltDiameter/2, 0);
  vertex(-boltDiameter/2, -boltLength);
  vertex(-nutWidth/2, -boltLength);
  vertex(-nutWidth/2, -boltLength  - nutThickness);
  vertex(nutWidth/2, -boltLength  - nutThickness);
  vertex(nutWidth/2, -boltLength);
  vertex(boltDiameter/2, -boltLength);
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
