import processing.pdf.*;
void setup() {
  size(400, 400);//, PDF, "dodecagon.pdf");
  background(255);
  
  stroke(0.5);
  translate(width/2, height/2);
  int numSides = 12;
  float r = width * 0.4;
  for(int i = 0; i < numSides; ++i) {
    float a0 = i * 2 * PI / numSides;
    float a1 = (i+1) * 2 * PI / numSides;
    line(r * cos(a0), r * sin(a0), r * cos(a1), r * sin(a1) );
  }
}
