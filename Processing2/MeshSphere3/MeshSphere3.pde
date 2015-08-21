//import processing.opengl.*;

Mesh mesh;
int numberVertices = 100;
void setup() {
  size(720, 720, OPENGL);
  mesh = new Mesh(numberVertices);
  lights();
}

void draw() {
  background(255);
  translate(width/2, height/2, 0);
  rotateX((height/2 - mouseY) * 0.005);
  rotateY((mouseX - width/2) * 0.005);

  mesh.draw();
}
