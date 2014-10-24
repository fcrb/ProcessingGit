class CubicEquation {
  float a3, a2, a1, a0;
  float[] roots =  new float[3];

  CubicEquation(float a3_, float a2_, float a1_, float a0_) {
    a3 = a3_;
    a2 = a2_;
    a1 = a1_;
    a0 = a0_;
    float x = 0;
    while(dydx(x) == 0) {
      x += 1;
    }
    float y_ = 1;
    while (abs (y_) > 1e-6) {
      y_ = y(x);
      x -= y_ / dydx(x);
    }
    roots[0] = x;
    //now find quadratic
    roots[1]=Float.NaN;
  }

  float y(float x) {
    return a0 + x * (a1 + x * (a2 + x * a3));
  }

  float dydx(float x) {
    return a1 + x * (2 * a2 + x * 3 * a3);
  }
}
