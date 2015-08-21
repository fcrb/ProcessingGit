import processing.pdf.*;
int DOTS_PER_INCH = 72;
//Make the drawing square, 5.5 inches wide.
int WIDTH = DOTS_PER_INCH * 11 / 2;
int HEIGHT = DOTS_PER_INCH * 11 / 2;

void setup() {
  //suggestion: keep laserCutterExample.pdf open on Mac in Preview, 
  // then you can click it to update
  size(WIDTH, HEIGHT, PDF, "laserCutterExample.pdf");
  background(255);
  translate(width/2, height/2);
  
  //vector cut a circle, almost size of window. To cut,
  //stroke must be 0.001 inches or less, or 0.072 points
  strokeWeight (DOTS_PER_INCH * 0.001);
  //almost fill window. This helps when positioning the laser cutter to 
  //minimize waste
  float fractionOfWindow = 0.99;
  ellipse(0, 0, width * fractionOfWindow, height * fractionOfWindow);
  
  //raster (etching) needs thicker strokeWeight or filling
  rectMode(CENTER);
  strokeWeight(width/10);
  stroke(200);
  rect(0, 0, width * 0.4, height * 0.6);
  
  //again, but darker and thinner, giving depth to raster
  strokeWeight(width/20);
  stroke(0);
  noFill();
  rect(0, 0, width * 0.4, height * 0.6);
}
