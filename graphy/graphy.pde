import processing.pdf.*;

String FILE_NAME = "sqrt2xplus1";

int WIDTH_PIXELS = 600;
int HEIGHT_PIXELS = 400;
int MAX_INTERVALS_ON_X_AXIS = 10;

double X_MIN = -0.5;
double X_MAX = 6.5;
double Y_MIN = -0.5;
double Y_MAX = 3.5;

int NUMBER_FONT_SIZE = 16;
int FUNCTION_FONT_SIZE = 36;

boolean EQUALIZE_AXES = true;
boolean SHOW_GRID = false;

void createGraph() {
    Function f = new Function() {
    public double value(double x) {
      if (x < 0) {
        return 0;
      }
      return sqrt((float) (2 * x + 1.0));
    }
  };
  f.strokeWeight(1);

  graph.addFunction(f);
}

void examplePiecewiseGraph() {
  PWFunction pwf = new PWFunction();
  FunctionPiece piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return 2;
    }
  }
  , 0, 1, true, false);
  pwf.addPiece(piece);

  piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return 1;
    }
  }
  , 1, 2, false, false);
  pwf.addPiece(piece);

  piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return -1;
    }
  }
  , 2, 3, false, true);
  pwf.addPiece(piece);

  graph.addFunction(pwf );
}

void dampedSine() {
  PWFunction pwf = new PWFunction();
  FunctionPiece piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return -sin((float)(PI * x)) /(x*x+1);
    }
  }
  , 0, X_MAX, true, false);

  pwf.addPiece(piece);
  graph.addFunction(pwf );
}

void pieceWiseExample() {
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
