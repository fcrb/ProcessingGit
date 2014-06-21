import processing.pdf.*;  

void setup() {
  size(800, 1000, PDF, "polarPaper.pdf");

  background(255);
  translate(width/2, height/2);

  float diameterSpacing = width * 0.05;
  stroke(128);
  noFill();
  strokeWeight(0.25);
  for (int i = 1; i < 40; ++i) {
    if (i%5==0) 
      stroke(0);
    else
      stroke(192);

    ellipse(0, 0, i * diameterSpacing, i * diameterSpacing);
  }

  int numRadials = 12;
  for (int i = 0; i < numRadials; ++i) {
    rotate( 2 * PI /numRadials);
    line (- height, 0, height, 0);
  }
  rotate( PI /4);
  line (- height, 0, height, 0);
  rotate( PI /2);
  line (- height, 0, height, 0);
}
