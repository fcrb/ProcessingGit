//import processing.opengl.*;

Mesh mesh;
int numberVertices = 5000;
void setup() {
  size(720, 720, OPENGL);
  mesh = new Mesh(numberVertices);
  lights();
}

void draw() {
  background(0);
  translate(width/2, height/2, 0);
  rotateX((height/2 - mouseY) * 0.003);
  rotateY((mouseX - width/2) * 0.003);

  mesh.draw();
}
