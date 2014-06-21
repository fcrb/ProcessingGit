class Box {
  /*
  I can imagine this class answering whether it contains a point.
  For now, the interface will just be x, y, and z length of Box.
  */
  float xLength = width/3;
  float yLength = width/3;
  float zLength = width/3;

  void draw() {
    noFill();
    box(xLength, yLength, zLength);
  }
  
}
