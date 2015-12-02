"use strict";
var voronoi, bbox, sites;

function setup() {
  createCanvas(800, 600);
  voronoi = new Voronoi();
  bbox = {
    xl: 0,
    xr: 800,
    yt: 0,
    yb: 600
  }; // xl is x-left, xr is x-right, yt is y-top, and yb is y-bottom
  sites = [];
  var numPoints = 20;
  for (var ptCtr = 0; ptCtr < numPoints; ++ptCtr) {
    var pt = {
      x: random() * width,
      y: random() * height
    };
    sites.push(pt);
    ellipse(pt.x, pt.y, 3, 3);
  }

  noLoop();
}

function includeInDrawing(cell) {
  var maxRadius = height * 0.48;
  for (var edgeIndex in cell.halfedges) {
    var edge = cell.halfedges[edgeIndex].edge;
    println(edge);
    if (dist(edge.va.x, edge.va.y, width / 2, height / 2) > maxRadius) {
      return false;
    }
    if (dist(edge.vb.x, edge.vb.y, width / 2, height / 2) > maxRadius) {
      return false;
    }
  }
  return true;
}

function draw() {
  var diagram = voronoi.compute(sites, bbox);
  // for (var edgeIndex in diagram.edges) {
  //   var edge = diagram.edges[edgeIndex];
  //   if (edge.va.x > 0 && edge.va.x < width - 1) {
  //     if (edge.vb.x > 0 && edge.vb.x < width - 1) {
  //       if (edge.va.y > 0 && edge.va.y < height - 1) {
  //         if (edge.vb.y > 0 && edge.vb.y < height - 1) {
  //           line(edge.va.x, edge.va.y, edge.vb.x, edge.vb.y);
  //         }
  //       }
  //     }
  //   }
  // }
  for (var cellIndex in diagram.cells) {
    var cell = diagram.cells[cellIndex];
    println(cell);
    if (includeInDrawing(cell)) {
      for (var edgeIndex in cell.halfedges) {
        var edge = cell.halfedges[edgeIndex].edge;
        line(edge.va.x, edge.va.y, edge.vb.x, edge.vb.y);
      }
    }
  }
}