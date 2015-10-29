class EdgeCalculator { 
  float MAX_ERROR =  1;
  PImage img;
  ArrayList<EdgePath> paths;
  //boolean[][] onEdge;

  EdgeCalculator(String inputFileName) {
    img = loadImage("input/"+inputFileName+".jpg");

    filterToBlackAndWhiteOnly();

    removeInteriorPixels();
    removeExtraEdgePixels();
    removeExtraEdgePixels();

    buildVectors();
  }

  void filterToBlackAndWhiteOnly() {
    img.loadPixels();
    int i = 0;
    for (int pixel : img.pixels) {
      float gray = (red(pixel) + green(pixel) + blue(pixel)) / 3;
      img.pixels[i++] = gray > 127 ? WHITE : BLACK;
    }
    img.updatePixels();
  }

  void createEdgeOnlyPDF(String filename, float pixelWidth) {
    int drawingWidth = 1 +(int) pixelWidth;
    int drawingHeight = 1 + (int) (height * pixelWidth / width);

    float strokeWt = 0.072;
    float scale = pixelWidth / width;

    PGraphics pdf = createGraphics(drawingWidth, drawingHeight, PDF, "pdf/"+filename);
    pdf.beginDraw();

    drawVectors(strokeWt, scale, pdf);

    pdf.dispose();
    pdf.endDraw();
  }

  void drawVectors(float strokeWt, float scale, PGraphics pdf) {
    pdf.strokeWeight(strokeWt);
    for (EdgePath path : paths) {
      path.draw(scale, pdf);
    }
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
        if (isOnEdge(i, j) && ! onAPath[i][j]) {
          onAPath[i][j] = true;
          EdgePath path = new EdgePath(i, j);
          path.populatePath(img.pixels, onAPath);
          if (path.nodes.size() > MIN_NODES_PER_PATH) {
            paths.add(path);
            numberOfNodes += path.nodes.size();
          }
        }
      }
    }
    print("buildVectors(): " + paths.size() + " paths, created " + numberOfNodes + " nodes");

    //for each path, eliminate vectors without losing image quality
    numberOfNodes = 0;
    for (EdgePath path : paths) {
      path.reducePath( MAX_ERROR);
      numberOfNodes += path.nodes.size();
    }
    println(", trimmed to " + numberOfNodes + " nodes.");
  }

  void removeInteriorPixels() {
    int[] pixelCopy = new int[img.pixels.length];
    arrayCopy(img.pixels, pixelCopy);
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        if (numBackgroundNeighbors(i, j) == 0) 
          pixelCopy[j * width +i] = WHITE;
      }
    }
    arrayCopy(pixelCopy, img.pixels);
    img.updatePixels();
  }

  void removeExtraEdgePixels() {
    for (int i = 1; i < width-1; ++i) {
      for (int j = 1; j < height-1; ++j) {
        //If BLACK, then change to WHITE if this pixel
        //has adjacent BLACK pixels that are
        //diagonal from each other.
        if ( img.pixels[j * width +i]==BLACK) {
          if (img.pixels[(j-1) * width +i]==BLACK ||img.pixels[(j+1) * width +i]==BLACK)
            if (img.pixels[j * width +i - 1]==BLACK ||img.pixels[j * width +i + 1]==BLACK)
              img.pixels[j * width +i] = WHITE;
        }
      }
    }
    img.updatePixels();
  }

  boolean isOnEdge(int x, int y) {
    int pixelOffset = y * width + x;
    return img.pixels[pixelOffset] == BLACK;
  }

  int numBackgroundNeighbors(int x, int y) {
    //find the pixel value of (up to) 8 neighboring img.pixels
    //start at 12 o'clock, go clockwise
    int numNeighbors = 0;
    for (NeighborPixel n : neighbors) {
      if (isBackgroundColor(n.pixel(img.pixels, x, y))) {
        numNeighbors++;
      }
    }
    return numNeighbors;
  }

  boolean isBackgroundColor(int clr) {
    return clr == WHITE;
  }
}