import processing.pdf.*;

boolean LEFT_HAND = false;
String FILE_NAME = "genericNoRect_"+(LEFT_HAND ? "LH" : "RH");
float X_LIMIT_LEFT = 0;
float X_LIMIT_RIGHT = 4;
int NUM_INTERVALS = 4;

int WIDTH_PIXELS = 400;
int HEIGHT_PIXELS = 300;
int MAX_INTERVALS_ON_X_AXIS = 5;

double X_MIN = -0.5;
double X_MAX = 4.5;
double Y_MIN = -0.5;
double Y_MAX = 3.5;

int NUMBER_FONT_SIZE = 18;
int FUNCTION_FONT_SIZE = 36;

boolean EQUALIZE_AXES = true;
boolean SHOW_GRID = true;
boolean SHOW_LABELS = false;

void createGraph() {
  Function f = new Function() {
    public double value(double x) {
      return 2 - cos((float)(x - PI/3 ));
    }
  };
  f.strokeWeight(1);

  graph.setFunction(f);
  graph.setIntegrationRange(X_LIMIT_LEFT, X_LIMIT_RIGHT
    , NUM_INTERVALS, LEFT_HAND);
}
