class Mesh {
  float radius = 1;
  ArrayList<Vertex> vertices;

  Mesh(int numVertices) {
    vertices = new ArrayList<Vertex>();
    for (int i = 0; i < numVertices; ++i) {
      vertices.add(new Vertex());
    }
    findNeighbors();
  }

  void draw() {
    drawConnectedVertices();
//    drawConnectedNeighbors();
  }

  void drawVertices() {
    for (Vertex vertex: vertices) {
      vertex.draw();
    }
  }

  void drawConnectedVertices() {
    float maxSep = maxSeparation();
    for (Vertex v1: vertices) {
      for (Vertex v2: vertices) {
        if (v1 != v2) {
          float d = dist(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
          float c1 = 255 * d / maxSep;
          float c2 = 255-c1;
          stroke(0, c2, c1, 50);
          line(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
        }
      }
    }
  }

  void drawConnectedNeighbors() {
    stroke(0, 0, 255, 50);
    for (Vertex v: vertices) {
      for (Vertex n: v.neighbors) {
        line(v.x, v.y, v.z, n.x, n.y, n.z);
      }
    }
  }

  void findNeighbors() {
    for (Vertex v1: vertices) {
      for (Vertex v2: vertices) {
        if (v1 != v2) {
          v1.tryNeighbor(v2);
        }
      }
    }
  }

  float maxSeparation() {
    float maximum = 0;
    for (Vertex v1: vertices) {
      for (Vertex v2: vertices) {
        if (v1 != v2) {
          float d = dist(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
          if (d > maximum) {
            maximum = d;
          }
        }
      }
    }
    return maximum;
  }
}
