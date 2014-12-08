import processing.pdf.*;

int hFreq = 5;
int vFreq = 13;
int sw = 32;
float[] widthsInInches =  new float[]{1};

void setup() {
  size(1000, 1000);//  size(32, 39);
  initializeEdgeCalculator();
  background(255);
  noSmooth();
  lissajousCircular();

  for(float w : widthsInInches) {
    int wholePart = (int) w;
    String wString = ""+wholePart + '_' + nf( round(100 * (w - wholePart)), 2);
    createEdgeOnlyPDF("lissajousCircular_"+hFreq+"h_"+vFreq+"v_"+sw+"sw_"+wString+"in.pdf", 72 * w );
//    createEdgeOnlyPDFSheet("lissajousCircular_"+hFreq+"h_"+vFreq+"v_"+sw+"sw"+wString+"in.pdf", 72 * w , 12, 1);
  }
}

void lissajousCircular() {
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  float insetFraction = 0.9;
//  float MAX_RADIUS = dist(0, 0, width, height) * insetFraction / 2;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 8 * PI / numSteps * i;
    x = width * insetFraction/2  * cos (hFreq * angle) * cos(vFreq * angle);
    y = height * insetFraction/2 * sin (hFreq * angle);
    if (i>0) {
      float adjustedSw = sw * dist(0,0,width,height) / 800 ;
      strokeWeight(adjustedSw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  //add loop for wire
  float diameter = width * 0.09;
  ellipse(0, -height * 0.41, diameter,diameter);
}
