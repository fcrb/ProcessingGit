//import processing.pdf.*;
//
EllipticGraph graph;

void setup() {
  size(800, 800);//, PDF, "graphyEllipticOutput.pdf");
  ellipticDemo();

  background(255);
  graph.draw();
  //  exit();
}

void ellipticDemo() {
  float[][] a = new float[4][4];
  a[3][0] = -7.8;
  a[2][1] = -5.4;
  a[1][2] = 1.7;
  a[0][3] = -2;
  a[2][0] = 1;
  a[1][1] = 1;
  a[0][2] = 1;
  a[1][0] = 1;
  a[0][1] = 1;
  a[0][0] = -0.4;
  graph = new EllipticGraph(-1.2, 1.2, -1.2, 0.5, a );
}
