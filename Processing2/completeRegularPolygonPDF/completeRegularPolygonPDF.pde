import processing.pdf.*;

int numVertices = 13;
float radius;
boolean rotate = false;

void setup() {
  size(480, 480, PDF, "/output/completeRegularPolygon.pdf");
  radius = width * 0.48;
}

void draw() {
  background(255);
  smooth();
  translate(width/2, height/2);
  float rotationAngle = 0;
  for (int i = 0; i < numVertices; ++i) {
    float angle1 = i * 2 * PI / numVertices + rotationAngle;
    float x1 = radius * cos(angle1);
    float y1 = radius * sin(angle1);
    for (int j = i+1; j < numVertices; ++j) {
      float colorScalar = min(j-i, numVertices - (j-i)) * 512.0 / numVertices;
      stroke( 0,colorScalar, 200);
      float angle2 = j * 2 * PI / numVertices + rotationAngle;
      float x2 = radius * cos(angle2);
      float y2 = radius * sin(angle2);
      line(x1, y1, x2, y2);
    }
  }
   // Exit the program 
  println("Finished.");
  exit();
}

void setNumberVertices(int n) {
  numVertices = n;
}
