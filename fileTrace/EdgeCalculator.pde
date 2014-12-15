class EdgeCalculator { 
  PImage img;
  ArrayList<EdgePath> paths;
  boolean[][] onEdge;

  EdgeCalculator(String fileName) {
    img = loadImage("input/"+inputFileName+".png");
    blackenAnyNonWhite();
    fillHoles();
    removeSpurious(5);
    findEdgePixels();
    buildVectors();
  }

  void blackenAnyNonWhite() {
    img.loadPixels();
    int i = 0;
    for (int pixel : img.pixels) {
      float gray = (red(pixel) + green(pixel) + blue(pixel)) / 3;
      img.pixels[i++] = gray > 127 ? WHITE : BLACK;
    }
    img.updatePixels();
  }

  void fillHoles() {
    img.loadPixels();
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        int pixelIndex = i + j * width;
        int pixel = img.pixels[pixelIndex];
        int numWhiteNeighbors = numBackgroundNeighbors(i, j);
        if (pixel == WHITE) {
          if (numWhiteNeighbors < 2) {
            img.pixels[pixelIndex] =BLACK;
          }
        }
      }
    }
    img.updatePixels();
  }

  void removeSpurious(int cycles) {
    img.loadPixels();
    for (int cycle = 0; cycle < cycles; ++cycle) {
      for (int i = 1; i < width-1; ++i) {
        for (int j = 1; j < height-1; ++j) {
          int pixelIndex = i + j * width;
          int pixel = img.pixels[pixelIndex];
          int numWhiteNeighbors = numBackgroundNeighbors(i, j);
          if (pixel == BLACK) {
            if (numWhiteNeighbors > 5) {
              img.pixels[pixelIndex] = WHITE;
            }
          }
        }
      }
    }
    img.updatePixels();
  }

  void addPixelLayer() {
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        if (onEdge[i][j]) {
          for (int dx = -1; dx < 2; ++dx) {
            for (int dy = -1; dy < 2; ++dy) {
              img.pixels[(j+dy) * width + i + dx] = 0 ;
            }
          }
        }
      }
    }
  }

  void removePixelLayer() {
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        if (onEdge[i][j]) {
          img.pixels[j * width + i ] = WHITE ;
        }
      }
    }
  }

  void drawVectors(float strokeWt, float scale, PGraphics pdf) {
    pdf.strokeWeight(strokeWt);
    for (EdgePath path : paths) {
      path.draw(scale, pdf);
    }
  }

  int[] pxls() {
    return img.pixels;
  }

  void buildVectors() {
    if (paths != null) { 
      return;
    }

    paths = new ArrayList<EdgePath>();
    boolean[][] onAPath = new boolean[width][height];
    int numberOfNodes = 0;
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        if (onEdge[i][j] && ! onAPath[i][j]) {
          //create a path. Add this as first node
          onAPath[i][j] = true;
          EdgePath path = new EdgePath(i, j);
          path.populatePath(pxls(), onEdge, onAPath);
          if (path.nodes.size() > 1) {
            paths.add(path);
            numberOfNodes += path.nodes.size();
          }
        }
      }
    }
    println("buildVectors() created " + paths.size() + " paths, using " + numberOfNodes + " nodes.");
  }

  void reduceVectors(float maxErrorFromLine) {
    //for each path, eliminate vectors without losing image quality
    int numberOfNodes = 0;
    for (EdgePath path : paths) {
      path.reducePath( maxErrorFromLine);
      numberOfNodes += path.nodes.size();
    }
    println("reduceVectors(): " + paths.size() + " paths, using " + numberOfNodes + " nodes.");
  }


  void findEdgePixels() {
     onEdge = new boolean[width][height];
   //skip 1 pixel border all the way around, simplifying 
    //implementation
    for (int i = 0; i < width; ++i) {
      for (int j = 0; j < height; ++j) {
        onEdge[i][j] = isOnEdge(i, j);
      }
    }
  }

  void removeNonEdgePixels() {
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        if (!onEdge[i][j]) {
          img.pixels[j * width +i] = WHITE;
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
          img.pixels[j * width +i] = WHITE;
        }
      }
    }
  }

  boolean neighborsAreConnected(int x, int y) {
    int firstNeighborIndex = -1;
    int prevNeighborIndex = -1;
    int index = 0;
    //for each neighbor of (x,y), see if it reachable 
    // from all other neighbors without stepping on x,y.
    //First, gather up live neighbors
    ArrayList<NeighborPixel> liveNeighbors = new ArrayList<NeighborPixel>();
    for (NeighborPixel n : neighbors) {
      if (!isBackground(n.pixel(img.pixels, x, y))) {
        liveNeighbors.add(n);
      }
    }
    if (liveNeighbors.size() == 2) {
      //must be at most one row and on column apart
      NeighborPixel n0 = liveNeighbors.get(0);
      NeighborPixel n1 = liveNeighbors.get(1);
      return abs(n0.dx - n1.dx) < 2 && abs(n0.dy - n1.dy) < 2;
    }
    println("3+ neighbors at"+x+','+y);
    for (NeighborPixel n : neighbors) {
      //only check neighbors that are on the edge
      if (!isBackground(n.pixel(img.pixels, x, y))) {
        if (firstNeighborIndex == -1) {
          firstNeighborIndex = index;
        } else {
          if (prevNeighborIndex % 2 == 0) {
            //previous is in side of 3x3
            if (index - prevNeighborIndex > 2) {
              //TODO
              //could be this pixel is closer to first pixel
              return false;
            }
          } else {
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
    if (isBackground(img.pixels[y * width + x])) {
      return false;
    }
    int n = numBackgroundNeighbors(x, y);

    //if there are 7-8 background neighbors, this is a spur or speck, so ignore
    //if there are 0 background neighbors, it is an interior point, 
    return n > 0 && n < 8;
  }

  int numBackgroundNeighbors(int x, int y) {
    //find the pixel value of (up to) 8 neighboring img.pixels
    //start at 12 o'clock, go clockwise
    int numNeighbors = 0;
    for (NeighborPixel n : neighbors) {
      if (isBackground(n.pixel(img.pixels, x, y))) {
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
