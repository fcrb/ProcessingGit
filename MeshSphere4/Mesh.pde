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
//    fill(0,0,255,20);
//    noStroke();
//   sphere(0.35*width);
    //    drawVertices();
    //    drawConnectedVertices();
    drawConnectedNeighbors();
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
          float d = v1.distance(v2);
          float c1 = 255 * d / maxSep;
          float c2 = 255-c1;
          stroke(0, c2, c1, 50);
          line(v1.v.x, v1.v.y, v1.v.z, v2.v.x, v2.v.y, v2.v.z);
        }
      }
    }
  }

  void drawConnectedNeighbors() {
//    findNeighbors();
    stroke(0, 0, 255, 50);
    for (Vertex v1: vertices) {
      v1.draw();
    }
    for (Vertex v1: vertices) {
      ArrayList<Vertex> nList = v1.neighbors();
      for (Vertex v2: nList) {
        line(v1.v.x, v1.v.y, v1.v.z, v2.v.x, v2.v.y, v2.v.z);
      }
    }
  }

  float maxSeparation() {
    float maximum = 0;
    for (Vertex v1: vertices) {
      for (Vertex v2: vertices) {
        if (v1 != v2) {
          float d = v1.distance(v2);
          if (d > maximum) {
            maximum = d;
          }
        }
      }
    }
    return maximum;
  }
}
