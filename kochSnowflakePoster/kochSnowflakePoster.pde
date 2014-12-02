import processing.pdf.*;
int sideLengthInches = 27;
int w = sideLengthInches * 72+5;
int h = (int) (sideLengthInches * 72 * sqrt(3)/2)+5;

void setup() {
  size(w, h, PDF, "triangle27in.pdf");
  background(255);
  strokeWeight(0.5);
  translate(2, 2);
  int tickLength = 2;
  for (int i = 0; i < 3; ++i) {
    //side
    line(0, 0, sideLengthInches * 72, 0);
    //tick marks
    line(sideLengthInches * 24, 0, sideLengthInches * 24, tickLength);
    line(sideLengthInches * 48, 0, sideLengthInches * 48, tickLength);
    //get ready for next side
    translate(sideLengthInches * 72, 0);
    rotate(2 * PI/3);
  }
}
