class NeighborPixel {
  int dx, dy;

  NeighborPixel(int dx_, int dy_) {
    dx = dx_; 
    dy= dy_;
  }
  
  int pixel(int x, int y) {
    return pixels[(y + dy) * width + x + dx];
  }
}
