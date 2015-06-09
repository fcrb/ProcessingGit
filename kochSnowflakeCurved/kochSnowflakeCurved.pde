import processing.pdf.*;

int[] rotations;//a rotation is the number of rotations by PI/3
int level = 6;

void setup() {
  size(800, 800);
  background(255);
  strokeWeight(0.005);
  buildRotations();
  float sizeScalar = 0.8;
  float sideLength = width * sizeScalar;
  PGraphics pdf = createGraphics(width, height, PDF, "kochSnowflakeCurved.pdf");
  pdf.beginDraw();
  pdf.beginShape();

  float x = width * 0.35 ;
  float y = height * 0.5;
  pdf.vertex(x, y);
  int totalRotation = 0;
  float segmentLength = sideLength * pow(1.0/3, level);
  int segmentCtr = 0;
//  for(int k = 0; k < 3; ++k) {
  for (int rotation : rotations) {
    float angle = totalRotation * PI / 3 -  2 * PI /rotations.length * segmentCtr++;
    x += cos(angle) * segmentLength;
    y += sin(angle) * segmentLength;
    totalRotation += rotation;
    pdf.vertex(x, y);
  }
  pdf.endShape();
  pdf.dispose();
  pdf.endDraw();
  exit();
}

void buildRotations() {
  rotations = new int[] { 
   -2//, -2//, -2
  };
  for (int lvl = 0; lvl < level; ++lvl) {
    int[] newRotations = new int[rotations.length * 4];
    int i = 0;
    for (int rotation : rotations) {
      newRotations[i++] = 1;
      newRotations[i++] = -2;
      newRotations[i++] = 1;
      newRotations[i++] = rotation;
    }
    rotations = newRotations;
  }
}
