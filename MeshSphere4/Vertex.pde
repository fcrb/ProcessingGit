class Vertex {
  Vec3D v;

  Vertex() {
    v = new Vec3D();
    v.scaleBy(0.4 * width);
  }

  void draw() {
    stroke(255, 0, 0);
    fill(255, 0, 0);
    v.add(netForce());
    v.normalize();
    //    Vec3D v2 = v.copy();
    v.scaleBy(0.4 * width);
    pushMatrix();
    translate(v.x, v.y, v.z);
   // point(0,0,0);
    //sphere(5);
    popMatrix();

  }

  float distance(Vertex other) {
    return v.distance(other.v);
  }

  Vec3D netForce() {
    Vec3D net = new Vec3D();
    net.scaleBy(0);
    for (Vertex vertex : mesh.vertices) {
      if (vertex != this) {
        Vec3D force = v.copy();
        force.subtract(vertex.v);
        float forceSize = force.length();
        force.scaleBy(1/forceSize/forceSize);
        net.add(force);
      }
    }
    net.scaleBy(width * 5);
    //    println(net.displayString());
    return net;
  }

  ArrayList<Vertex> neighbors() {
    ArrayList<Vertex> neighborList = new ArrayList<Vertex>();
    float[] distances = new float[mesh.vertices.size()];
    for (int i = 0; i < distances.length; ++i) {
      distances[i] = distance(mesh.vertices.get(i ));
    }
    distances = sort(distances);
    float maxNeighborDistance = distances[numberNeighbors];
    for (Vertex n : mesh.vertices) {
      if (n != this && distance(n) <= maxNeighborDistance) {
        neighborList.add(n);
      }
    }
    return neighborList;
  }

  //  boolean hasNeighbor(Vertex n) {
  //    return neighbors.contains(n );
  //  }
}
