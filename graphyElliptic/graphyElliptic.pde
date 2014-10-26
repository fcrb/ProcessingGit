import processing.pdf.*;

PFont myFont;
EllipticGraph graph;

void setup() {
  size(640, 480, PDF, "graphyEllipticOutput.pdf");
  textMode(SHAPE);
  // Uncomment the following two lines to see the available fonts 
  //  String[] fontList = PFont.list();
  //  println(fontList);
  myFont = createFont("CMUSerif-Roman", 12);
  textFont(myFont);

  noLoop();

  ellipticDemo();

  background(255);
  graph.draw();
  exit();
}

void ellipticDemo() {
  float[][] a = new float[3][3];
  a[2][3] = 1;
  a[1][3] = 1;
  a[1][2] = 1;
  a[2][1] = 1;
  a[1][1] = 1;
  a[2][0] = 1;
  a[0][0] = 1;
  graph = new EllipticGraph(-2.2, 2.2, -1.1, 0.5, a);
  graph.addFunctor(new Functor() {
    public float value(float x) {
      return x*x;
    }
  }
  );
  graph.addFunctor(new Functor() {
    public float value(float x) {
      return x*x*x - x;
    }
  }
  );
}
