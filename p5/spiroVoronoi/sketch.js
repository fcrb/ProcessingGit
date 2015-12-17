"use strict";
var voronoi, bbox, sites;
var needsRedraw = true;

//UI
var numPointsSlider, fixedRingSlider, rollingRingSlider, outerRadiusSlider, innerRadiusSlider;
var insideCheckbox;

function setup() {
  createCanvas(800, 800);

  var widgetOffset = 120;
  numPointsSlider = makeSlider("Number points", 11, 251, 51, widgetOffset, 20, 2);
  fixedRingSlider = makeSlider("Fixed ring", 1, 20, 4, widgetOffset, 50, 1);
  rollingRingSlider = makeSlider("Rolling ring", 1, 20, 7, widgetOffset, 80, 1);
  innerRadiusSlider = makeSlider("Inner radius", 0, width / 4, 0, widgetOffset, 110, 1);
  outerRadiusSlider = makeSlider("Outer radius", width / 4, width, width / 2, widgetOffset, 140, 1);

  insideCheckbox = makeCheckbox("inside", false, widgetOffset, 170);
}

function gcf(a, b) {
  if (a < b) {
    return gcf(b, a);
  }
  if (a == b) {
    return a;
  }
  return gcf(b, a - b);
}

function spiroPoints() {
  voronoi = new Voronoi();
  bbox = {
    xl: 0,
    xr: width,
    yt: 0,
    yb: height
  }; // xl is x-left, xr is x-right, yt is y-top, and yb is y-bottom
  sites = [];
  var numPoints = numPointsSlider.value();
  var fixedRing = fixedRingSlider.value();
  var rollingRing = rollingRingSlider.value();
  var radius = width * 0.4;
  var r1 = radius * fixedRing / (fixedRing + rollingRing);
  var r2 = radius - r1;
  for (var ptCtr = 0; ptCtr < numPoints; ++ptCtr) {
    var angle1 = 2 * fixedRing * rollingRing * PI * ptCtr / numPoints;
    var angle2 = angle1 * fixedRing / rollingRing;
    if (insideCheckbox.checked()) {
      angle2 = -angle2;
    }
    var pt = {
      x: width / 2 + r1 * cos(angle1) + r2 * cos(angle2),
      y: width / 2 + r1 * sin(angle1) + r2 * sin(angle2)
    };

    sites.push(pt);
  }
}

function includeInDrawing(cell) {
  var maxRadius = outerRadiusSlider.value();
  var minRadius = innerRadiusSlider.value();
  for (var edgeIndex in cell.halfedges) {
    var edge = cell.halfedges[edgeIndex].edge;
    var aDistToCenter = dist(edge.va.x, edge.va.y, width / 2, height / 2);
    if (aDistToCenter > maxRadius || aDistToCenter < minRadius) {
      return false;
    }
    var bDistToCenter = dist(edge.vb.x, edge.vb.y, width / 2, height / 2);
    if (bDistToCenter > maxRadius || bDistToCenter < minRadius) {
      return false;
    }
  }
  return true;
}

function draw() {
  if (!needsRedraw) {
    return;
  }
  needsRedraw = false;
  background(255);
  spiroPoints();
  try {
    var cf = gcf(fixedRingSlider.value(), rollingRingSlider.value());
    var labelOffset = 250;
    text("" + numPointsSlider.value(), labelOffset, 33);
    text("" + fixedRingSlider.value() + " (" + fixedRingSlider.value() / cf + ')', labelOffset, 63);
    text("" + rollingRingSlider.value() + " (" + rollingRingSlider.value() / cf + ')', labelOffset, 93);

    var diagram = voronoi.compute(sites, bbox);
    for (var cellIndex in diagram.cells) {
      var cell = diagram.cells[cellIndex];
      // println(cell);
      if (includeInDrawing(cell)) {
        for (var edgeIndex in cell.halfedges) {
          var edge = cell.halfedges[edgeIndex].edge;
          line(edge.va.x, edge.va.y, edge.vb.x, edge.vb.y);
        }
      }
    }
  } catch (e) {}
}