import processing.pdf.*;

PFont myFont;
Graph graph;

void setup() {
  size(640, 480, PDF, "graphyOutput.pdf");
  textMode(SHAPE);
  // Uncomment the following two lines to see the available fonts 
  //  String[] fontList = PFont.list();
  //  println(fontList);
  myFont = createFont("CMUSerif-Roman", 12);
  textFont(myFont);

  noLoop();

  graph = new Graph(-2.2, 2.2, -1.1, 0.5);
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
  background(255);
  //  beginRecord(PDF, "graphyOutput.pdf");
  graph.draw();
  //  endRecord();
  exit();
}
