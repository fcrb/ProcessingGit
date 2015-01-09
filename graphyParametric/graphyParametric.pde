import processing.pdf.*;

String FILE_NAME = "graphyOutput";

int WIDTH_PIXELS = 480;
int HEIGHT_PIXELS = 480;
int MAX_INTERVALS_ON_X_AXIS = 14;

double X_MIN = -6;
double X_MAX = 6;
double Y_MIN = -6;
double Y_MAX = 6;

int NUMBER_FONT_SIZE = 12;
int FUNCTION_FONT_SIZE = 36;

boolean EQUALIZE_AXES = true;
boolean SHOW_GRID = true;

void createGraph() {
  PWFunction pwf = new PWFunction();
  FunctionPiece piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return x*x;
    }
  }
  , -1, 0.5, true, false);
  
  pwf.addPiece(piece);
  graph.addFunction(pwf );
}

void quarticAndDerivatives() {
  Function f = new Function() {
    public double value(double x) {
      return x*x * (x*x-1);
    }
  };
  createFunctionAndFirstTwoDerivatives(f, "", "", "");
}

void arctanFunctionAndDerivatives() {
  Function f = new Function() {
    public double value(double x) {
      return atan((float)x);//1/(1+x*x);
    }
  };
  createFunctionAndFirstTwoDerivatives(f, "", "", "");
}

void cauchyFunctionAndDerivatives() {
  Function f = new Function() {
    public double value(double x) {
      return 1/(1+x*x);
    }
  };
  createFunctionAndFirstTwoDerivatives(f, "", "", "");
}

void normaDensityAndDerivatives() {
  Function f = new Function() {
    public double value(double x) {
      return exp((float) (-x*x/2))/sqrt(2 * PI);
    }
  };
  createFunctionAndFirstTwoDerivatives(f, "", "", "");
}

void piecewiseLineAndParabola() {
  Function f = new Function() {
    public double value(double x) {
      if (x < 0) {
        return -x;
      }
      return x*x;
    }
  };
  f.strokeWeight(1);

  graph.addFunction(f);
}

//Utility functions

void createFunctionAndFirstTwoDerivatives(Function f, String fLabel, String f1Label, String f2Label) {
  //Create and add Functions
  //  f.strokeWeight(1);
  f.label(fLabel);

  Function g = new NumericalDerivative(f);
  //  g.strokeWeight(3);
  //  g.stroke(200, 150);
  g.label(f1Label);

  Function h = new NumericalDerivative(g);
  //  h.strokeWeight(2);
  //  h.stroke(100, 150);
  h.label(f2Label);

  graph.addFunction(f);
  graph.addFunction(g);
  graph.addFunction(h);
} 
