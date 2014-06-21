ArrayList<Cube> cubes;
void setup() {
  size(480, 270, OPENGL);
  cubes = new ArrayList<Cube>();
  int cubesPerSide = 4;
  int spaceBetweenCubes = 1;
  int spaceScale = spaceBetweenCubes+1;
  for (int i = 0; i < cubesPerSide; ++i) {
    for (int j = 0; j < cubesPerSide; ++j) {
      for (int k = 0; k < cubesPerSide; ++k) {
        cubes.add(new Cube(i*spaceScale, j*spaceScale, k*spaceScale));
      }
    }
  }
}

void draw() {
  background(0);
  translate(width/2, height/2, 0);
  rotateX((height/2 - mouseY) * 0.01);
  rotateY((mouseX - width/2) * 0.01);
  for (Cube cube: cubes) {
    cube.draw();
  }
}
int cubeSize = 20;

class Cube {
  int x, y, z;
  int cFill;
  int cStroke;

  Cube(int x_, int y_, int z_) {
    x=x_;
    y=y_;
    z=z_;
    int r = 255 - x * 10;
    int g = 255 - y * 10;
    int b = 255 - z * 10;
    cFill = color(r, g, b);
    float strokeScale = 0.9;
    cStroke = color(r*strokeScale, g*strokeScale, b*strokeScale);
  }

  void draw() {
    pushMatrix();
    translate(cubeSize * x, cubeSize * y, cubeSize * z);
    fill(cFill);
    stroke(cStroke);
    box(cubeSize);
    popMatrix();
  }
}

