import processing.pdf.*;
void setup() {
  size(500, 72, PDF, "rectangles.pdf");

  float txtSize = 24;
  textSize(txtSize);
  background(255, 255);
  fill(0);
  noFill();
  strokeWeight(0.072);
  stroke(0);
  //cut 12 rectangles
  for (int i = 1; i < 13; ++i) {
    float x = (i-0.5) * txtSize * 1.4;
    float y =  txtSize*1.2;
    text(""+i, x, y);
    //the jth rectangle is cut j times
    for (int j = 0; j < i; ++j) {
      rect(x, y*1.2, txtSize, txtSize);
    }
  }
}
