class Complex {
  float real, imaginary;
  
  Complex(float r, float i) {
    real = r;
    imaginary = i;
  }
  
  Complex copy() {
    return new Complex(real, imaginary);
  }
  
  float lengthSquared() {
    return real * real + imaginary * imaginary;
  }
 
  Complex plus(Complex z) {
    return new Complex(z.real + real, z.imaginary + imaginary);
  }

  Complex times(Complex z) {
    return new Complex(z.real * real - z.imaginary * imaginary, real * z.imaginary + z.real * imaginary);
  }
  
}
