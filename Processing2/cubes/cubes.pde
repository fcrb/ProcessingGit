ArrayList<Cube> cubes;
void setup() {
  size(480, 270, OPENGL);
  cubes = new ArrayList<Cube>();
  int cubesPerSide = 5;
  int spaceBetweenCubes = 1;
  int spaceScale = spaceBetweenCubes+1;
  int halfCubes = cubesPerSide / 2;
  for (int i = -halfCubes; i < cubesPerSide-halfCubes; ++i) {
    for (int j =  -halfCubes; j < cubesPerSide-halfCubes; ++j) {
      for (int k =  -halfCubes; k < cubesPerSide-halfCubes; ++k) {
        cubes.add(new Cube(i*spaceScale, j*spaceScale, k*spaceScale));
      }
    }
  }
}

void draw() {
  background(0);
  translate(width/2, height/2,0);
  rotateX((height/2 - mouseY) * 0.01);
  rotateY((mouseX - width/2) * 0.01);
  for (Cube cube: cubes) {
    cube.draw();
  }
}
