class EdgeCalculator {
  int WHITE = color(255);
  boolean[][] onEdge;

  EdgeCalculator() {
    onEdge = new boolean[width][height];
    findEdgePixels();
  }

  void drawEdges(float strokeWeight) {
  }

  void findEdgePixels() {
    //skip 1 pixel border all the way around, simplifying 
    //implementation
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        onEdge[i][j] = isOnEdge(i, j);
      }
    }
  }

  void removeNonEdgePixels() {
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        if(!onEdge[i][j]) {
          pixels[j * width +i] = WHITE;
        }
      }
    }
  }

  boolean isOnEdge(int x, int y) {
    if (isBackground(pixels[y * width + x])) {
      return false;
    }
    //find the pixel value of (up to) 8 neighboring pixels
    //start at 12 o'clock, go clockwise
    int[] deltaX = new int[] { 
      0, 1, 1, 1, 0, -1, -1, -1
    };
    int[] deltaY = new int[] { 
      -1, -1, 0, 1, 1, 1, 0, -1
    };
    int numBackgroundNeighbors = 0;
    for (int i = 0; i < 8; ++i) {
      if (isBackground(pixels[(y +deltaY[i])* width + x + deltaX[i]])) {
        numBackgroundNeighbors++;
      }
    }
    //if there are 7-8 background neighbors, this is a spur or speck, so ignore
    //if there are 0 background neighbors, it is an interior point, 
    return numBackgroundNeighbors > 0 && numBackgroundNeighbors < 7;
  }

  boolean isBackground(int clr) {
    //for now, if it isn't white, its a candidate for being on the edge
    //So this should work whether aliased or not
    return clr == WHITE;
  }
}
