void setup() {
  size(100, 100);
//  CubicEquation e = new CubicEquation(1, -3, -10, 24);
  CubicEquation e = new CubicEquation(1, 0 , 0, - 27);
  for (float r : e.roots ) {
    println(r);
  }
}
