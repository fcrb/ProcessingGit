int cubeSize = 20;

class Cube {
  int x, y, z;
  int cFill;
  int cStroke;

  Cube(int x_, int y_, int z_) {
    x=x_;
    y=y_;
    z=z_;
    int r = 255 - x * 10;
    int g = 255 - y * 10;
    int b = 255 - z * 10;
    cFill = color(r, g, b);
    float strokeScale = 0.9;
    cStroke = color(r*strokeScale, g*strokeScale, b*strokeScale);
  }

  void draw() {
    pushMatrix();
    translate(cubeSize * x, cubeSize * y, cubeSize * z);
    fill(cFill);
    stroke(cStroke);
    box(cubeSize);
    popMatrix();
//    if(millis()>3000) {
//      x *= 1 + random (-0.02, 0.25);
//      y *= 1 + random (-0.02, 0.25);
//      z *= 1+ random (-0.02, 0.25);
//    }
  }
}
