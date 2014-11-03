float frequency1 = sqrt(17);
float frequency2 = PI;
float frequency3 = 5;
int strokeWeightScalar = 2;

interface JavaScript {
  void showValues(int f1, int f2);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(800,320);
  noLoop();
  stroke(0, 100);
}

void setFrequency1(float n) {
  frequency1 = n;
  redraw();
} 

void setFrequency2(float n) {
  frequency2 = n;
  redraw();
} 

void draw() {
  background(255);
//  if (javascript!=null) 
//    javascript.showValues(frequency1, frequency2);
  pushMatrix();
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
      float diag = dist(0,0,width, height);
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 12 * PI / numSteps * i;
    x = width * .45 * cos(frequency1 * angle);
    y = height * .225 * (cos(frequency2 * angle)+ cos(frequency3 * angle));
    if (i>0) {
      float sw = strokeWeightScalar * 0.01 * diag / (1 + dist(x, y, 0, 0)/diag) ;
      strokeWeight(1);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  popMatrix();
}
