"use strict";

var numPolys = 7;
var numSquaresPerSide = 3;
var sideLength;
var fcSeq;

//UI
var numPolysSlider, numSquaresPerSideSlider, strokeWeightSlider, fillCheckbox;
var needsRedraw = true;
var saveCommandSequence = false;

function setup() {
  createCanvas(800, 800);
  fcSeq = new FunctionCallSequence("test.json");
  numPolysSlider = makeSlider("number of polygons", 3, 16, 3, 150, 20, 1);
  numSquaresPerSideSlider = makeSlider("squares on each edge", 0, 6, 1, 150, 50, 1);
  strokeWeightSlider = makeSlider("stroke weight", 0.5, 15, 0.5, 150, 80, 0.5);
  fillCheckbox = makeCheckbox("fill polygons", false, 150, 110);
}

function numSides() {
  if (numPolys % 2 == 0) {
    return numPolys;
  }
  return 2 * numPolys;
}

function keyPressed() {
  if (key == 'S') {
    fcSeq.writeToFile();
  }
}

function draw() {
  if (!needsRedraw) {
    return;
  }
  needsRedraw = false;
  clear();
  fcSeq.reset();
  fcSeq.background(255);
  numPolys = numPolysSlider.value();
  numSquaresPerSide = numSquaresPerSideSlider.value();
  //slider value labels
  fill(0);
  text(numPolys, 280, 33);
  text(numSquaresPerSide, 280, 63);

  // strokeCap(1);
  fcSeq.strokeWeight(strokeWeightSlider.value());
  fcSeq.translate(width / 2, height / 2);
  sideLength = PI * width / numSides() * 0.36;
  for (var polyCtr = 0; polyCtr < numPolys; ++polyCtr) {
    drawPoly();
    fcSeq.rotate(2 * PI / numPolys);
  }
}

function drawPoly() {
  fcSeq.push();
  for (var sideCtr = 0; sideCtr < numSides(); ++sideCtr) {
    drawSideAsPolygons();
    fcSeq.translate(sideLength, 0);
    fcSeq.rotate(2 * PI / numSides());
  }
  fcSeq.pop();
}

function useFill() {
  return fillCheckbox.checked();
}

function drawPolyVertex(polySideLength) {
  if (useFill()) {
    fcSeq.fill(200);
  } else {
    noFill();
  }
  strokeJoin(ROUND);
  for (var sideCtr = 0; sideCtr < numPolys; ++sideCtr) {
    var vertex_ = new Vector2D(0, 0);
    var delta = new Vector2D(polySideLength, 0);
    fcSeq.beginShape();
    for (var edgeCtr = 0; edgeCtr < numPolys; ++edgeCtr) {
      fcSeq.vertex(vertex_.x, vertex_.y)
      vertex_ = vertex_.plus(delta);
      delta = delta.rotate(2 * PI / numPolys);
    }
    fcSeq.endShape(CLOSE);
  }
}

function drawSideAsPolygons() {
  //side consists of two perpendiculars from numSide-sided
  //center to edge, plus one or more squares 
  //Assume they have side length one, then scale to fit sideLength.

  //Draw the polygon centered at the origin
  fcSeq.stroke(127);
  fcSeq.push();
  var ratioAltitudeToHalfSide = tan(PI / 2 - PI / numPolys);
  var polySideLength = sideLength / (ratioAltitudeToHalfSide + numSquaresPerSide);
  var polyAltitude = ratioAltitudeToHalfSide * polySideLength / 2;
  fcSeq.push();
  //rotate vertex into position
  fcSeq.rotate(-PI / 2 + PI / numSides() * 2);
  fcSeq.translate(-polySideLength / 2, -polyAltitude);
  drawPolyVertex(polySideLength);
  fcSeq.pop();

  if (useFill()) {
    fcSeq.fill(225);
  } else {
    noFill();
  }
  fcSeq.translate(polyAltitude + polySideLength / 2, 0);
  fcSeq.rectMode(CENTER);
  strokeJoin(ROUND);
  for (var squareCtr = 0; squareCtr < numSquaresPerSide; ++squareCtr) {
    fcSeq.rect(0, 0, polySideLength, polySideLength);
    fcSeq.translate(polySideLength, 0);
  }
  fcSeq.pop();

}