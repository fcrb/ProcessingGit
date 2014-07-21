class Complex {
  float real, imag;

  Complex(float a, float b) {
    real = a;
    imag = b;
  }

  float abs2() {
    return real * real + imag * imag;
  }

  int colorMapped() {
    if (real > 0) {
      return imag > 0 ? 255 : 0;
    }
    return imag > 0 ? 170 : 85;
  }

  int blackWhite() {
    return real * imag > 0 ? 255 : 0;
  }

  Complex conjugate() {
    return new Complex(real, -imag );
  }

  Complex divideBy(Complex z) {
    return times(z.conjugate()).scaleBy(1 / z.abs2());
  }

  Complex raisedTo(int n) {
    if (n < 0) { 
      return new Complex(1, 0).divideBy(raisedTo(-n));
    }
    if (n == 0) {
      return new Complex(1, 0);
    }
    if (n ==1 ) { 
      return new Complex(real, imag);
    }
    return this.times(raisedTo(n - 1));
  }

  Complex minus(Complex z) {
    return new Complex(real - z.real, imag - z.imag);
  }

  Complex plus(Complex z) {
    return new Complex(real + z.real, imag + z.imag);
  }

  Complex scaleBy(float s) {
    return new Complex(real * s, imag * s);
  }

  float cosh(float x) {
    float e_x = exp(x);
    return (e_x + 1/e_x) / 2;
  }

  float sinh(float x) {
    float e_x = exp(x);
    return (e_x - 1/e_x) / 2;
  }

  Complex sine() {
    return new Complex(sin(real) * cosh(imag), cos(real) * sinh(imag));
  }

  Complex times(Complex z) {
    return new Complex(real * z.real - imag * z.imag, real * z.imag + imag * z.real);
  }
}
