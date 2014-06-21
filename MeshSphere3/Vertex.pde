class Vertex {
  Vec3D v;
  ArrayList<Vertex> neighbors;
  Vertex mostDistantNeighbor;
  float distanceToMostDistant;
  int numberNeighbors = 5;

  Vertex() {
    v = new Vec3D();
    v.scaleBy(0.4 * width);
    neighbors = new ArrayList<Vertex>();
    distanceToMostDistant = (float) 1e+10;
  }

  void draw() {
    stroke(255, 0, 0);
    fill(255, 0, 0);
    point(v.x, v.y, v.z);
  }
  
  float distance(Vertex other) {
    return v.distance(other.v);
  }

  void tryNeighbor(Vertex n) {
    if (n == this) return;
    if (hasNeighbor(n)) return;
    float dToN = distance(n);
    if (dToN >= distanceToMostDistant )
      return;
    if (neighbors.size() >= numberNeighbors && mostDistantNeighbor != null) {
      neighbors.remove(mostDistantNeighbor);
    }
    neighbors.add(n);
    //update most distant
    distanceToMostDistant = -1;
    for (Vertex neighbor : neighbors) {
      dToN = distance(neighbor);
      if (dToN >= distanceToMostDistant ) {
        mostDistantNeighbor = n;
        distanceToMostDistant = dToN;
      }
    }
  }

  boolean hasNeighbor(Vertex n) {
    return neighbors.contains(n );
  }
}
