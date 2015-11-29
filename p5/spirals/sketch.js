"use strict";

/* Upcoming features?
..optional ring around edge
..find points of intersection, and stop drawing at last intersection before edge
..variable pen width
..optional center hole with ring
*/

var maxPenWidth = 30;
var fixedPenWidth = false;
var maxPenWidth = 30;
var needsRedraw = true;
var WIDTH_MULTIPLIER = 0.44;

var canvas, baseSlider, cwSpiralSlider, ccwSpiralSlider, maxPenWidthSlider;
var fixedPenWidthCheckbox;

function setup() {
  createCanvas(960, 960);

  baseSlider = makeSlider("base", 1.1, 5, 1.61, 90, 20, 0.01);
  cwSpiralSlider = makeSlider("CW spirals", 1, 21, 5, 90, 50, 1);
  ccwSpiralSlider = makeSlider("CCW spirals", 1, 21, 8, 90, 80, 1);
}

function draw() {
  if (!needsRedraw) {
    return;
  }
  push();
  needsRedraw = false;
  background(255);
  translate(width / 2, height / 2);
  scale(1, -1);
  stroke(127);

  spiral(cwSpiralSlider.value());
  scale(-1, 1);
  spiral(ccwSpiralSlider.value());
  var d = width / 8;
  // fill(255);
  // ellipse(0, 0, d, d);
  noFill();
  stroke(255);
  strokeWeight(width);
  ellipse(0, 0, width * 1.99, width * 1.99);
  pop();

  //slider value labels
  text("" + baseSlider.value(), 185, 33);
  text("" + cwSpiralSlider.value(), 185, 63);
  text("" + ccwSpiralSlider.value(), 185, 93);

}

function spiral(numArms) {
  for (var i = 0; i < numArms; ++i) {
    spiralArm();
    rotate(2 * PI / numArms);
  }
}

function spiralArm() {
  var base = baseSlider.value();
  var angle = -PI;
  var dAngle = PI / 60;
  var rMultiplier = pow(base, dAngle);
  var x, y, xPrev, yPrev;
  var r = pow(base, angle);
  while (r < width) {
    x = r * cos(angle);
    y = r * sin(angle);
    if (xPrev != null) {
      strokeWeight(dist(0, 0, x, y) / width * 20);
      line(xPrev, yPrev, x, y);
    }
    xPrev = x;
    yPrev = y;
    angle += dAngle;
    r *= rMultiplier;
  }
}