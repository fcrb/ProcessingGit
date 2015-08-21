class Stroke {
  float x0, y0, x1, y1, strokeWt;

  Stroke(float x0_, float y0_, float x1_, float y1_, float strokeWt_) {
    x0 = x0_;
    y0 = y0_;
    x1 = x1_;
    y1 = y1_;
    strokeWt = strokeWt_;
  }

  void drawSymmetrically() {
    //disallow drawing outside the diameter of drawing area
    for (int i = 0; i < SYMMETRY; ++i) {
      rotate(2 * PI /  SYMMETRY);
      hexLine(x0, y0, x1, y1, strokeWt);
      hexLine(-x0, y0, -x1, y1, strokeWt);
    }
  }
}
