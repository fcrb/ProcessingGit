class Vertex {
  int x, y;

  Vertex(int x_, int y_) {
    x = x_;
    y = y_;
  }

  float screenX( ) {
    return (x + 0.5) * segmentLength;
  }

  float screenY( ) {
    return  height - (y + 0.5) * segmentLength;
  }

  float xMidpoint(Vertex v) {
    return 0.5 * (screenX() + v.screenX());
  }

  float yMidpoint(Vertex v) {
    return 0.5 * (screenY() + v.screenY());
  }
}