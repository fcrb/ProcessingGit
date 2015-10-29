ArrayList<NeighborPixel> neighbors;
int WHITE = color(255);
int BLACK = color(0);
float PIXELS_PER_INCH = 72;
float maxError = 1.0e-9;
int sheetPadding = 5;

class NeighborPixel {
  int dx, dy;

  NeighborPixel(int dx_, int dy_) {
    dx = dx_; 
    dy= dy_;
  }

  int pixel(int[] pxls, int x, int y) {
    //if(offset >= pxls.length) {
    //  println("pxlsLength="+pxls.length + " offset=" + offset + " x=" + x + " y="+y);
    //  return color(255);
    //}
    //If on edge, assume area outside of picture is background color
    if (isOutOfPicture(x, y)) {
      return WHITE;
    }
    int offset = (y + dy) * width + x + dx;
    //println("pxlsLength="+pxls.length + " offset=" + offset + " x=" + x + " y="+y);
    return pxls[offset];
  }

  boolean isBackground(int[] pxls, int x, int y) {
    return pixel(pxls, x, y) == WHITE;
  }

  boolean isOutOfPicture(int x, int y) {
    return x + dx < 1 || x + dx >= width ||y + dy < 1 || y + dy >= height;
  }
}

void outline() {
   //loadPixels();
   //EdgeCalculator ec = new EdgeCalculator();
   //ec.blackenAnyNonWhite();
   //for (int i = 0; i < 10; ++i ) {
   //  ec.removeNonEdgePixels();
   //  ec.removeExtraNeighbors();
   //}
  
  edgeCalculator.buildVectors();
  edgeCalculator.reduceVectors(maxError);
  //  updatePixels();
  //  return ec;
}

void createEdgeOnlyPDF(String filename, float pixelWidth) {
  int drawingWidth = 1 +(int) pixelWidth;
  int drawingHeight = 1 + (int) (height * pixelWidth / width);

  float strokeWt = 0.072;
  float scale = pixelWidth / width;

  PGraphics pdf = createGraphics(drawingWidth, drawingHeight, PDF, "pdf/"+filename);
  pdf.beginDraw();

  edgeCalculator.drawVectors(strokeWt, scale, pdf);

  pdf.dispose();
  pdf.endDraw();
}

void createEdgeOnlyPDFSheet(String filename, float pixelWidth, int numX, int numY) {
  //  EdgeCalculator ec = outline();
  //
  //  int drawingWidth = 1 +(int) pixelWidth;
  //  int drawingHeight = 1 + (int) (height * pixelWidth / width);
  //  float strokeWt = 0.072;
  //  float scale = pixelWidth / width;
  //
  //  //make it 24x18
  //  int maxWidth = numX * (drawingWidth + sheetPadding) + sheetPadding;
  //  int maxHeight = numY * (drawingHeight + sheetPadding)+ sheetPadding;
  //  PGraphics pdf = createGraphics(maxWidth, maxHeight, PDF, "pdf/"+filename);
  //  pdf.beginDraw();
  //
  //  int yTranslate = sheetPadding;
  //  for (int i = 0; i < numY; ++i) {
  //    int xTranslate = sheetPadding;
  //    for (int j = 0; j < numX; ++j) {
  //      pdf.pushMatrix();
  //      pdf.translate(xTranslate, yTranslate);
  //      ec.drawVectors(strokeWt, scale, pdf);
  //      pdf.popMatrix();
  //      xTranslate += drawingWidth + sheetPadding;
  //    }
  //    yTranslate += drawingHeight + sheetPadding;
  //  }
  //  pdf.dispose();
  //  pdf.endDraw();
}

void initializeNeighborPixelArray() {
  neighbors = new ArrayList<NeighborPixel>();
  neighbors.add(new NeighborPixel(0, -1));
  neighbors.add(new NeighborPixel(1, -1));
  neighbors.add(new NeighborPixel(1, 0));
  neighbors.add(new NeighborPixel(1, 1));
  neighbors.add(new NeighborPixel(0, 1));
  neighbors.add(new NeighborPixel(-1, 1));
  neighbors.add(new NeighborPixel(-1, 0));
  neighbors.add(new NeighborPixel(-1, -1));
}

class Vec2D {
  float x, y;

  Vec2D(float x_, float y_) {
    x = x_;
    y=y_;
  }

  Vec2D minus(Vec2D v) {
    return new Vec2D(x - v.x, y - v.y);
  }

  Vec2D plus(Vec2D v) {
    return new Vec2D(x + v.x, y + v.y);
  }

  float length() {
    return dist(x, y, 0, 0);
  }

  float innerProduct(Vec2D other) {
    return x* other.x + y * other.y;
  }

  Vec2D scaleBy(float s) {
    return new Vec2D(x * s, y * s);
  }

  Vec2D projectOnto(Vec2D v) {
    float vLength = v.length();
    float lambda = innerProduct(v) / (vLength * vLength) ;
    return v.scaleBy(lambda);
  }

  float distanceFrom(Vec2D v) {
    Vec2D difference = minus(v);
    return difference.length();
  }

  float distanceFromProjectionOnto(Vec2D v) {
    Vec2D projection = projectOnto(v);
    return distanceFrom(projection);
  }

  String toString() {
    return "Vec2D("+x+','+y+')';
  }
}