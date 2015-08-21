import processing.pdf.*;

int numVerticesOnTop = 19;
float upperBendFactor = 0.55;
float lowerBendFactor = 0.4;
float rightShift = -0.4;
int lengthInches = 26;
boolean showJoints = false;

void setup() {
  size(800, 300);//  size(32, 39);
  initializeEdgeCalculator();
  drawTruss();
  String fileName = "truss_"+numVerticesOnTop+"n_"+upperBendFactor+"ub_"+lowerBendFactor+"lb_"+rightShift+"rs_"+lengthInches+"in.pdf";
//    createEdgeOnlyPDF(fileName, 72 * lengthInches );
}

void drawTruss() {
  background(255);
  noSmooth();
  fill(255);
  translate(width/2, height/10);
  float dx = width / (numVerticesOnTop + 1);
  float trussHeight = dx / 2 * sqrt(3);
  strokeWeight(trussHeight*0.167);
  strokeCap(ROUND);
  ArrayList<Joint> topJoints = new ArrayList<Joint>();
  for (int i = 0; i < numVerticesOnTop; ++i) {
    float x = (i  -  numVerticesOnTop * 0.5 +0.5 + rightShift)  * dx;
    float y = x * x / width * upperBendFactor;
    topJoints.add(new Joint(x, y));
    if ( i > 0) {
      line(x, y, topJoints.get(i-1).x, topJoints.get(i-1).y);
    }
  }
  ArrayList<Joint> bottomJoints = new ArrayList<Joint>();
  for (int i = 0; i <= numVerticesOnTop; ++i) {
    float x = (i  -  numVerticesOnTop* 0.5 + rightShift )  * dx;
    float y = x * x / width * lowerBendFactor + trussHeight;
    bottomJoints.add(new Joint(x, y));
    if ( i != numVerticesOnTop) {
      line(x, y, topJoints.get(i).x, topJoints.get(i).y);
    }
    if ( i != 0) {
      line(x, y, topJoints.get(i-1).x, topJoints.get(i-1).y);
    }
    if ( i > 0) {
      line(x, y, bottomJoints.get(i-1).x, bottomJoints.get(i-1).y);
    }
  }
  if (showJoints) {
    strokeWeight(trussHeight/10);
    float jointDiameter = trussHeight/5;
    for (Joint j: topJoints) {
      ellipse(j.x, j.y, jointDiameter, jointDiameter);
    }
    for (Joint j: bottomJoints) {
      ellipse(j.x, j.y, jointDiameter, jointDiameter);
    }
  }
}

class Joint {
  float x, y;

  Joint(float x_, float y_) {
    x = x_;
    y = y_;
  }
}
