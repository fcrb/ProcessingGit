import processing.pdf.*;

String FILE_NAME = "graphyOutput";

int WIDTH_PIXELS = 640;
int HEIGHT_PIXELS = 480;
int MAX_INTERVALS_ON_X_AXIS = 14;

double X_MIN = -6.8;
double X_MAX = 6.8;
double Y_MIN = -5;
double Y_MAX = 0.9;

int NUMBER_FONT_SIZE = 12;
int FUNCTION_FONT_SIZE = 36;

boolean EQUALIZE_AXES = true;
boolean SHOW_GRID = true;

void createGraph() {
  //Create and add Functions
  Function f = new Function() {
    public double value(double x) {
      return 1/(1+x*x);
    }
  };
  f.stroke(255, 0, 0, 150);
  f.strokeWeight(1);
  f.label("f");

  Function g = new NumericalDerivative(f);
  g.stroke(200);
  g.label("f'");

  Function h = new NumericalDerivative(g);
  h.label("f''");

  Function j = new NumericalDerivative(h);
  j.label("f'''");

  graph.addFunction(f);
  graph.addFunction(g);
  graph.addFunction(h);
  graph.addFunction(j);

  //Create and add Functions
  Point p = new Point(0, 1);
  p.fill(0, 0, 100, 200);
  graph.addPoint(p);
}
