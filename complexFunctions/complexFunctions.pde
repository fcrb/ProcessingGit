void setup() {
  size(640, 640);

  float range = 2;
  float xMin = -range;
  float xMax = range;
  float yMin = -range;
  float yMax = range;

  for (int i = 0; i < width; ++i) {
    float x = xMin + i * (xMax - xMin) / width;
    for (int j = 0; j < height; ++j) {
      float y = yMax - j * (yMax - yMin) / height;
      Complex z = new Complex(x, y);
//      stroke(f(z).colorMapped());
      stroke(f(z).blackWhite());
      point(i, j);
    }
  }
}

Complex f(Complex z) {
  //  return z.raisedTo(4);
  //  return z.raisedTo(3).minus(z).plus(z.times(z).scaleBy(4));
//  return new Complex(1, 0).divideBy(z).plus(z);
//  return new Complex(0, 3).divideBy(z).plus(z);
//  return new Complex(2, 2).divideBy(z).plus(z);
//    return z.sine().plus(new Complex(2, 2).divideBy(z).plus(z));
//    return new Complex(1,0).divideBy(z).plus(z).sine();
    return new Complex(1,0).divideBy(z).plus(z.times(new Complex(2, 2))).plus(z.times(z)).sine();
}
