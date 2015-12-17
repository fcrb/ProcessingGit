"use strict";

var needsRedraw = true;

var rotationAngle = Math.PI / 8;
var minBranchLength = 10;
var rotationAngleSlider, branchLengthSlider, depthSlider, scaleSlider, tiltSlider;

//Voronoi
var voronoi, bbox, sites;

function setup() {
  createCanvas(800, 800);
  var sliderInset = 105;
  rotationAngleSlider = makeSlider("rotation angle", 0.05, 1, 0.15, sliderInset, 20, 0.01);
  branchLengthSlider = makeSlider("branch length", 0.1, 0.99, 0.9, sliderInset, 50, 0.01);
  scaleSlider = makeSlider("scale", 0.01, 1, 0.25, sliderInset, 80, 0.01);
  depthSlider = makeSlider("depth", 1, 10, 8, sliderInset, 110, 1);
  tiltSlider = makeSlider("tilt", -1, 1, 0, sliderInset, 140, 0.001);
}

function draw() {
  if (!needsRedraw) {
    return;
  }
  // strokeWeight(penWidthSlider.value());
  needsRedraw = false;
  voronoi = new Voronoi();
  bbox = {
    xl: 0,
    xr: width,
    yt: 0,
    yb: height
  };
  sites = [];

  push();
  background(255);
  stroke(127);
  try {
    var trunkLength = height * 0.5 * scaleSlider.value();
    drawTree(width / 2, height * 0.99, width / 2, height * 0.99 - trunkLength, 0);

    //draw Voronoi
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
  } catch (e) {
    println(e);
  }

  noFill();
  strokeWeight(1);
  var labelInset = 320;
  text(rotationAngleSlider.value(), labelInset, 33);
  text(branchLengthSlider.value(), labelInset, 63);
  text(scaleSlider.value(), labelInset, 93);
  text(depthSlider.value(), labelInset, 123);
  text(tiltSlider.value(), labelInset, 153);
}

function drawTree(x0, y0, x1, y1, depth) {
  if (x1 < 1 || x1 >= width || y1 < 1 || y1 >= height) {
    return;
  }
  if (depth > depthSlider.value()) {
    return;
  }
  sites.push(new Vector2D(x1, y1));
  var delta = new Vector2D(x1 - x0, y1 - y0);
  var rotationAngle = rotationAngleSlider.value();
  for (var branchCtr = 0; branchCtr < 2; ++branchCtr) {
    var angle = rotationAngle + tiltSlider.value();
    var v = delta.rotate(angle);
    v = v.scaleBy(branchLengthSlider.value());
    drawTree(x1, y1, x1 + v.x, y1 + v.y, depth + 1);
    rotationAngle = -rotationAngle;
  }
}

function includeInDrawing(cell) {
  var maxRadius = height * 0.48;
  for (var edgeIndex in cell.halfedges) {
    var edge = cell.halfedges[edgeIndex].edge;
    if (edge.va.x < 1 || edge.va.x > width - 1 || edge.va.y < 1 || edge.va.y > height - 1) {
      return false;
    }
    if (edge.vb.x < 1 || edge.vb.x > width - 1 || edge.vb.y < 1 || edge.vb.y > height - 1) {
      return false;
    }
    // if (dist(edge.va.x, edge.va.y, width / 2, height / 2) > maxRadius) {
    //   return false;
    // }
    // if (dist(edge.vb.x, edge.vb.y, width / 2, height / 2) > maxRadius) {
    //   return false;
    // }
  }
  return true;
}