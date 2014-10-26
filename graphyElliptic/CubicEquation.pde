class CubicEquation {
  float a3, a2, a1, a0;
  float[] roots;

  CubicEquation(float a3_, float a2_, float a1_, float a0_) {
    a3 = a3_;
    a2 = a2_;
    a1 = a1_;
    a0 = a0_;

    findRoots();
  }

  void findRoots() {
    float x = PI;//pick arbitrary starting point
    float y_ = 1;//stopping criteria is y_ close to zero
    while (abs (y_) > 1e-6) {
      y_ = y(x);
      x -= y_ / dydx(x);
    }
    //now solve quadratic
    float a = a3;
    float b = a2 + a * x;
    float c = a1 + b * x;
    float discriminant = b * b - 4 * a * c;
    if (discriminant < 0) {
      //other roots are not real, so ignore them
      roots = new float[] { 
        x
      };
      return;
    } 

    if (discriminant == 0) {
      //one real root of multiplicity two, we will only show one
      roots = new float[] { 
        x, -b /(a + a)
        };
        return;
    } 

    //    //two distinct real roots
    discriminant = sqrt(discriminant);
    roots = new float[] { 
      x, (-b + discriminant)/(a+a), (-b - discriminant)/(a+a)
    };
  }


  float y(float x) {
    return a0 + x * (a1 + x * (a2 + x * a3));
  }

  float dydx(float x) {
    return a1 + x * (2 * a2 + x * 3 * a3);
  }
}
