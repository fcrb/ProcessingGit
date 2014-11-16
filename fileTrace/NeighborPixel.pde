class NeighborPixel {
  int dx, dy;

  NeighborPixel(int dx_, int dy_) {
    dx = dx_; 
    dy= dy_;
  }

  int pixel(int x, int y) {
    //If on edge, assume area outside of picture is background color
    if(isOutOfPicture(x,y)) {
      return WHITE;
    }
    return pixels[(y + dy) * width + x + dx];
  }

  boolean isBackground(int x, int y) {
    return pixel(x,y) == WHITE;
  }

  boolean isOutOfPicture(int x, int y) {
    return x + dx < 1 || x + dx >= width ||y + dy < 1 || y + dy >= height;
  }
}
