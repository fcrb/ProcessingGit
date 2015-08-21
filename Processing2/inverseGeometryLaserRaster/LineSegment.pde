class LineSegment {
  float x0, y0, x1, y1;

  LineSegment( float x0_, float y0_, float x1_, float y1_) {
    x0 = x0_;
    y0 = y0_;
    x1 = x1_;
    y1 = y1_;
  }

  void draw() {
    line(x0, y0, x1, y1);
  }

  void drawInvertedNonstandard(float scalar) {
    Point a = new Point(x0, y0 );
    a.invertAndRotate(scalar);
    Point b = new Point(x1, y1 );
    b.invertAndRotate(scalar);
    a.midPoint(b).setDistStrokeWeight();

    line(a.x, a.y, b.x, b.y);
  }

  void drawInverted(float scalar) {
    Point a = new Point(x0, y0 );
    a.invert(scalar);
    Point b = new Point(x1, y1 );
    b.invert(scalar);
    a.midPoint(b).setDistStrokeWeight();
    line(a.x, a.y, b.x, b.y);
  }

  ArrayList<LineSegment> inPieces(int n ) {
    ArrayList<LineSegment> pieces = new ArrayList<LineSegment>();
    for (int i = 0; i < n ; ++i) {
      float xStep = (x1 - x0) / n;
      float yStep = (y1 - y0) / n;
      pieces.add(new LineSegment(x0 + i * xStep, y0 + i * yStep, x0 + (i+1) * xStep, y0 + (i+1) * yStep));
    }
    return pieces;
  }
}
