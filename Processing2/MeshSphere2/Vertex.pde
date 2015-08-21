class Vertex {
  float x, y, z;
  ArrayList<Vertex> neighbors;
  Vertex mostDistantNeighbor;
  float distanceToMostDistant;
  int numberNeighbors = 5;

  Vertex() {
    do {
      x = random(-width, width); 
      y = random(-width, width); 
      z = random(-width, width);
    }  
    while (length () > width);
    normalize();
    neighbors = new ArrayList<Vertex>();
    distanceToMostDistant = (float) 1e+10;
  }

  void draw() {
    stroke(255, 0, 0);
    fill(255, 0, 0);
    point(x, y, z);
  }

  float length() {
    return dist(0, 0, 0, x, y, z);
  }

  void normalize() {
    float d = 0.4 * width / length();
    x *= d;
    y *= d;
    z *= d;
  }

  void tryNeighbor(Vertex v) {
    if (v == this) return;
    if (hasNeighbor(v)) return;
    float dToV = dist(x, y, z, v.x, v.y, v.z);
    if (dToV >= distanceToMostDistant )
      return;
    if (neighbors.size() >= numberNeighbors && mostDistantNeighbor != null) {
      neighbors.remove(mostDistantNeighbor);
    }
    neighbors.add(v);
    //update most distant
    distanceToMostDistant = -1;
    for (Vertex n : neighbors) {
      float dToN = dist(x, y, z, n.x, n.y, n.z);
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
