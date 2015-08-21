class Segment {
  Vertex v1, v2;

  Segment(Vertex v1_, Vertex v2_) {
    v1 = v1_;
    v2 = v2_;
  }

  void draw() {
    strokeWeight(2);
    line(v1.screenX(), v1.screenY(), v2.screenX(), v2.screenY());
  }
  
  boolean contains(Vertex v) {
    return v == v1 || v == v2;
  }
  
  boolean canAddToPath(Path path) {
    return contains(path.lastVertexState().v) && !contains(path.previousVertexState().v);
  }
  
  int newMode(int oldMode) {
    return oldMode;
  }
}