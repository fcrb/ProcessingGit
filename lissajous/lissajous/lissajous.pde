int frequency1 = 6;
int frequency2 = 8;
int f3 = 9;
float sw = 10;

interface JavaScript {
  void showValues(int f1, int f2);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(640, 640);
  noLoop();
  stroke(0, 100);
}

void setFrequency1(int n) {
  frequency1 = n;
  redraw();
} 

void setFrequency2(int n) {
  frequency2 = n;
  redraw();
} 

void draw() {
//  drawRectangularLissajous();
  drawLissajous2();
}

void drawCircularLissajous() {
  //assumes width = height
  background(255);
  if (javascript!=null) 
    javascript.showValues(frequency1, frequency2);
  pushMatrix();
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  float radius = width * .45;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 2 * PI / numSteps * i;
    x = radius * cos(frequency1 * angle);
    y = radius * cos(frequency2 * angle);
    float scalar;
    if (abs(y) < abs(x)) {
      //projects onto left or right side
      float yMax = y/x * radius;
      scalar = radius / dist(0, 0, radius, yMax);
    } 
    else {
      //projects onto top or bottom side
      float xMax = x/y * radius;
      scalar = radius / dist(0, 0, xMax, radius);
    }
    x *= scalar;
    y *= scalar;
    if (i>0) {
      float sw = 10 / (500 + dist(x, y, 0, 0) / width * 800)* width;
      strokeWeight(sw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  popMatrix();
}

void drawRectangularLissajous() {
  background(255);
  if (javascript!=null) 
    javascript.showValues(frequency1, frequency2);
  pushMatrix();
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 2 * PI / numSteps * i;
    x = width * .45 * cos(frequency1 * angle);
    y = height * .45 * cos(frequency2 * angle);
    if (i>0) {
      float sw = 8000 / (500 + dist(x, y, 0, 0) / width * 800)* width/400;
      strokeWeight(sw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  popMatrix();
}
void drawLissajous2() {
  background(255);
  if (javascript!=null) 
    javascript.showValues(frequency1, frequency2);
  pushMatrix();
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 8 * PI / numSteps * i;
//    x = width * .45 * cos(frequency1 * angle) * cos (f3 * angle);
    x = width * .45  * cos (f3 * angle);
    y = height * .45 * cos(frequency2 * angle) * sin (f3 * angle);
    if (i>0) {
      strokeWeight(sw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  popMatrix();
}
