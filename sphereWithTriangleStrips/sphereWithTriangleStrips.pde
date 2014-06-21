float radius;
int numPoints = 30;
void setup() {
  size(640, 360, P3D);
  background(204);
  radius = height/3;
}

void draw() {
  background(204);

  translate(width/2, height/2, 0);
  rotateX(PI/8);
  beginShape(TRIANGLE_STRIP); 
  for (int i = 0; i <= numPoints; i++) {
    float theta = i * 2 * PI / numPoints;
    for (int j = 0; j <= numPoints; j++) {
      float phi = j * PI / numPoints - PI / 2;
      float x = radius * cos(theta) * cos(phi);
      float y = radius * sin(theta) * cos(phi);
      float z = radius * sin(phi);
      vertex(x, y, z);
    }
  }
  endShape();
}

