Graph graph;

void setup() {
  size(640, 480);
  noLoop();
  graph = new Graph(-2, 4, -1, 0.5);
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
  graph.draw();
}
