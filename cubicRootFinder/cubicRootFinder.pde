void setup() {
  size(100,100);
  CubicEquation e = new CubicEquation(1, 0, 3, -14);
  println(e.roots[0]);
  println(e.roots[1]);
  println(e.roots[2]);
}
