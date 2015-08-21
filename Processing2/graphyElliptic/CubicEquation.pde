class CubicEquation {
  float a3, a2, a1, a0;
  float[] roots;

  CubicEquation(float a3_, float a2_, float a1_, float a0_) {
    //make leading coefficient 1
    a3 = 1;
    if (a3_==0)
      println("div by zero in CubicEquation");
    a2 = a2_/a3_;
    a1 = a1_/a3_;
    a0 = a0_/a3_;

    findRoots();
  }

  float y(float x) {
    return a0 + x * (a1 + x * (a2 + x * a3));
  }



  void findRoots() {
    int MAX_ITERATIONS  = 25;
    float x = 0;
    float y_ = y(x);//stopping criteria is y_ close to zero
    //use binary search
    float upperX = 1;
    while (y (upperX) <= 0) upperX *= 2;
    float lowerX = -1;
    while (y (lowerX) >= 0) lowerX *= 2;

    int iterationCount = 0;
    while (abs (y_) > 1e-6 && iterationCount++ < MAX_ITERATIONS) {
      x = (upperX + lowerX) * 0.5;
      y_ = y(x);
      if (y_ < 0) {
        lowerX = x;
      }
      else {
        upperX = x;
      }
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
    //two distinct real roots
    discriminant = sqrt(discriminant);
    roots = new float[] { 
      x, (-b + discriminant)/(a+a), (-b - discriminant)/(a+a)
      };
    }

    //  float dydx(float x) {
    //    return a1 + x * (2 * a2 + x * 3 * a3);
    //  }
  }
