class EdgeCalculator { 
  ArrayList<EdgePath> paths;
  boolean[][] onEdge;

  EdgeCalculator() {
    onEdge = new boolean[width][height];
    findEdgePixels();
  }
  
  void drawVectors(float strokeWt) {
    strokeWeight(strokeWt);
    for(EdgePath path: paths) {
      path.draw();
    }
  }

  void buildVectors() {
    if (paths != null) { 
      return;
    }

    paths = new ArrayList<EdgePath>();
    boolean[][] onAPath = new boolean[width][height];
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        if (onEdge[i][j] && ! onAPath[i][j]) {
          //create a path. Add this as first node
          EdgePath path = new EdgePath(i, j);
          paths.add(path);
          path.populatePath( onEdge, onAPath);
        }
      }
    }
    println("buildVectors() created " + paths.size() + " paths.");
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
        if (onEdge[i][j] && neighborsAreConnected(i, j)) {
          onEdge[i][j] = false;
          pixels[j * width +i] = WHITE;
        }
      }
    }
  }

  boolean neighborsAreConnected(int x, int y) {
    int firstNeighborIndex = -1;
    int prevNeighborIndex = -1;
    int index = 0;
    for (NeighborPixel n : neighbors) {
      if (!isBackground(n.pixel(x, y))) {
        if (firstNeighborIndex == -1) {
          firstNeighborIndex = index;
        }   
        else {
          if (prevNeighborIndex % 2 == 0) {
            //previous is in side of 3x3
            if (index - prevNeighborIndex > 2) {
              //TODO
              //could be this pixel is closer to first pixel
              return false;
            }
          }
          else {
            //previous is in corner of 3x3
            if (index - prevNeighborIndex > 1) {
              return false;
            }
          }
        }
        prevNeighborIndex = index;
      }
      ++index;
    }
    return true;
  }

  boolean isOnEdge(int x, int y) {
    if (isBackground(pixels[y * width + x])) {
      return false;
    }
    int n = numBackgroundNeighbors(x, y);
    //if there are 7-8 background neighbors, this is a spur or speck, so ignore
    //if there are 0 background neighbors, it is an interior point, 
    return n > 0 && n < 7;
  }

  int numBackgroundNeighbors(int x, int y) {
    //find the pixel value of (up to) 8 neighboring pixels
    //start at 12 o'clock, go clockwise
    int numNeighbors = 0;
    for (NeighborPixel n : neighbors) {
      if (isBackground(n.pixel(x, y))) {
        numNeighbors++;
      }
    }
    return numNeighbors;
  }

  boolean isBackground(int clr) {
    //for now, if it isn't white, its a candidate for being on the edge
    //So this should work whether aliased or not
    return clr == WHITE;
  }
}

