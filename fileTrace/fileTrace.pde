import processing.pdf.*;

String inputFileName = "horcrux_bw";

void setup() {
  size(2404, 2083);//  size(32, 39);
  initializeEdgeCalculator();
  background(255);
  noSmooth();
  PImage img = loadImage("input/"+inputFileName+".png");
  image(img, 0, 0);

  createEdgeOnlyPDF(inputFileName+".pdf", 72*6);
}

