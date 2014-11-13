import processing.pdf.*;

int[] rotations;//a rotation is the number of rotations by PI/3
int level = 5;

void setup() {
  size(800, 800, PDF, "kochSnowflake.pdf");
  background(255);
  strokeWeight(0.005);
  buildRotations();
  float sizeScalar = 0.8;
  translate(width * (1 - sizeScalar)/2, height * (0.5 + sizeScalar * 0.285 ));
  float sideLength = width * sizeScalar * pow(1.0/3,level);
  for (int rotation : rotations) {
    line(0, 0, sideLength, 0);
    translate(sideLength, 0);
    rotate(PI / 3 * rotation);
  }
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

