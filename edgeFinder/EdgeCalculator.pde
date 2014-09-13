class EdgeCalculator {
  int WHITE = color(255);
  ArrayList<NeighborPixel> neighbors;
  boolean[][] onEdge;

  EdgeCalculator() {
    neighbors = new ArrayList<NeighborPixel>();
    neighbors.add(new NeighborPixel(0, -1));
    neighbors.add(new NeighborPixel(1, -1));
    neighbors.add(new NeighborPixel(1, 0));
    neighbors.add(new NeighborPixel(1, 1));
    neighbors.add(new NeighborPixel(0, 1));
    neighbors.add(new NeighborPixel(-1, 1));
    neighbors.add(new NeighborPixel(-1, 0));
    neighbors.add(new NeighborPixel(-1, -1));
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
        if (!onEdge[i][j]) {
          pixels[j * width +i] = WHITE;
        }
      }
    }
  }

  void removeExtraNeighbors() {
    //If all of my neighbors are neighbors to each other,
    //I can be removed. This happens if the max distance
    //(horizontal or vertical) between neighbors is 1.
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        if (onEdge[i][j]) {
          int maxDx = -2;
          int maxDy = -2;
          int minDx = 2;
          int minDy = 2;
          for (NeighborPixel n : neighbors) {
            if (onEdge[i + n.dx][j + n.dy]) {
              maxDx = max(maxDx, n.dx);
              maxDy = max(maxDy, n.dy);
              minDx = min(minDx, n.dx);
              minDy = min(minDy, n.dy);
            }
          }
          if ((maxDx - minDx > 1) || (maxDy - minDy > 1) ) {
            onEdge[i][j] = false;
          }
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
    int numBackgroundNeighbors = 0;
    for (NeighborPixel n : neighbors) {
      if (isBackground(n.pixel(x, y))) {
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
