int numVertices = 19;
float radius;

void setup() {
  size(1000, 1000);
  radius = width * 0.48;

  background(255);
  stroke(0);
  strokeWeight(5);
  strokeCap(ROUND);
  translate(width/2, height/2);
  for (int i = 0; i < numVertices; ++i) {
    float angle1 = i * 2 * PI / numVertices;
    float x1 = radius * cos(angle1);
    float y1 = radius * sin(angle1);
    for (int j = i+1; j < numVertices; ++j) {
      float angle2 = j * 2 * PI / numVertices ;
      float x2 = radius * cos(angle2);
      float y2 = radius * sin(angle2);
      line(x1, y1, x2, y2);
    }
  }
}

void setNumberVertices(int n) {
  numVertices = n;
}
