import processing.pdf.*;

String inputFileName = "GoThrones_bw";

void setup() {
  size(1436,1444);
  initializeEdgeCalculator();
  background(255);
  noSmooth();
  PImage img = loadImage("input/"+inputFileName+".png");
  image(img, 0, 0);

  createEdgeOnlyPDF(inputFileName+".pdf", 72*6);
}

