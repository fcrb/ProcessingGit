class Mesh {
  float radius = 1;
  ArrayList<Vertex> vertices;

  Mesh(int numVertices) {
    vertices = new ArrayList<Vertex>();
    for (int i = 0; i < numVertices; ++i) {
      vertices.add(new Vertex());
    }
  }

  void draw() {
    for (Vertex vertex: vertices) {
      vertex.draw();
    }
  }
}
