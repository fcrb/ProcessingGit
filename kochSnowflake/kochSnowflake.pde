import processing.pdf.*;

int[] rotations;//a rotation is the number of rotations by PI/3
int level = 5;

void setup() {
  size(800, 800);
  background(255);
  strokeWeight(0.005);
  buildRotations();
  float sizeScalar = 0.8;
  float sideLength = width * sizeScalar;
  PGraphics pdf = createGraphics(width, height, PDF, "kochSnowflake.pdf");
  pdf.beginDraw();
  pdf.beginShape();

  float x = width * (1 - sizeScalar)/2;
  float y = height * (0.5 + sizeScalar * 0.285);
  pdf.vertex(x, y);
  for (int rotation : rotations) {
    x += cos(totalRotation* PI /3) * segmentLength;
    y += sin(totalRotation* PI /3) * segmentLength;
    totalRotation = (totalRotation + rotation) % 6;
    pdf.vertex(x, y);
  }
  pdf.endShape();
  pdf.dispose();
  pdf.endDraw();
  exit();
}

void buildRotations() {
  rotations = new int[] { 
    -2, -2, -2
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
