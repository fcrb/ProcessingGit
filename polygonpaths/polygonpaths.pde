void setup() {
  size (640, 360);
  
  float x = width/3;
  float y = height/2;
  float r = width/4;
  int numSides = 10;
  Polygon p = new Polygon(x, y, r, numSides);
}
