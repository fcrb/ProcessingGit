ArrayList<NeighborPixel> neighbors;
int WHITE = color(255);
int BLACK = color(0);
float PIXELS_PER_INCH = 72;
float maxError = 0.25;

class MousePoint {
  float x, y;

  MousePoint(float x_, float y_) {
    x = x_;
    y = y_;
  }
}

class MousePath {
  ArrayList<MousePoint> points = new ArrayList<MousePoint>();
  void addMousePoint(int x, int y) {
    points.add(new MousePoint(x, y));
  }

  MousePoint first() {
    return points.get(0);
  }

  int length() {
    return points.size();
  }

  void smoothPath() {
    ArrayList<MousePoint> newPoints = new ArrayList<MousePoint>(points);
    //match beginning and end
    newPoints.set(0, points.get(0));
    int lastIndex = length()-1;
    newPoints.set(lastIndex, points.get(lastIndex));

    for (int idx = 1; idx < lastIndex; ++idx) {
      float xAvg = (points.get(idx-1).x + points.get(idx).x + points.get(idx+1).x ) / 3;
      float yAvg = (points.get(idx-1).y + points.get(idx).y + points.get(idx+1).y ) / 3;
      newPoints.set(idx, new MousePoint(xAvg, yAvg));
    }
    points = newPoints;
  }
}

class NeighborPixel {
  int dx, dy;

  NeighborPixel(int dx_, int dy_) {
    dx = dx_; 
    dy= dy_;
  }

  int pixel(int x, int y) {
    //If on edge, assume area outside of picture is background color
    if (isOutOfPicture(x, y)) {
      return WHITE;
    }
    return pixels[(y + dy) * width + x + dx];
  }

  boolean isBackground(int x, int y) {
    return pixel(x, y) == WHITE;
  }

  boolean isOutOfPicture(int x, int y) {
    return x + dx < 1 || x + dx >= width ||y + dy < 1 || y + dy >= height;
  }
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

void createEdgeOnlyPDF(String filename, float pixelWidth) {
  loadPixels();
  EdgeCalculator ec = new EdgeCalculator();
  ec.removeNonEdgePixels();
  ec.removeExtraNeighbors();
  ec.buildVectors();
  ec.reduceVectors(maxError);
  updatePixels();

  //Now you can scale down the size. 
  PGraphics pdf = createGraphics(1 +(int) pixelWidth, 1 + (int) (height * pixelWidth / width), PDF, "pdf/"+filename);
  pdf.beginDraw();

  float strokeWt = 0.02;
  float scale = pixelWidth / width;
  ec.drawVectors(strokeWt, scale, pdf);

  pdf.dispose();
  pdf.endDraw();
}

void initializeEdgeCalculator() {
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
