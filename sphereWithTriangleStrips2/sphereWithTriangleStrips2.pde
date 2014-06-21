float radius;
int numPoints = 100;
void setup() {
  size(640, 360, P3D);
  background(204);
  radius = height/3;
}

void draw() {
  background(0);
  lights();
  ambientLight(128, 128, 128);
//  directionalLight(128, 128, 128, (0.5-((float)mouseX)/width ), 0, -1);
  lightFalloff(1, 0.001, 0);
  pointLight(150, 250, 150, 50, 50, 50);

  lightSpecular(0, 0, 0);
  noStroke();
  translate(width/2, height/2, 0);
  fill(100, 100, 255);
  rotateX((height - mouseY) * 0.005);
  rotateZ(( width/2 - mouseX) * 0.005);
  float thetaStep =  2 * PI / numPoints;
  for (int i = 0; i <= numPoints; i++) {
    float phiStep =  PI / numPoints ;
    beginShape(TRIANGLE_STRIP); 
    float phi = -PI/2;
    for (int j = 0; j <= numPoints; j++) {
      float theta = i * 2 * PI / numPoints;
      for (int k= 0; k < 2; ++k) {
        createVertex(theta, phi);
        theta += thetaStep;
      }
      phi += phiStep;
    }
    endShape();
  }
}

void createVertex(float theta, float phi) {
  float x = radius * cos(theta) * cos(phi);
  float y = radius * sin(theta) * cos(phi);
  float z = radius * sin(phi);
  vertex(x, y, z);
}

