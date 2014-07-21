/*
The idea here was to create a library for quickly 
creating crease patterns. 
*/

float inset;
float paperWidth;

void setup() {
  size(480, 480);
  paperWidth = 432;
  inset = (width - paperWidth) * 0.5;

  background(255);
  strokeWeight(1);
  fill(255);
  translate(inset, inset);
  rect(0, 0, paperWidth, paperWidth);  
  line(0, 0, paperWidth, paperWidth);
}
