import processing.pdf.*;

String FILE_NAME = "pieceWise_HHG_p229";

int WIDTH_PIXELS = 600;
int HEIGHT_PIXELS = 400;
int MAX_INTERVALS_ON_X_AXIS = 10;

double X_MIN = -0.5;
double X_MAX = 6.5;
double Y_MIN = -0.5;
double Y_MAX = 3.5;

float FUNCTION_STROKE_WEIGHT = 2;

int NUMBER_FONT_SIZE = 16;
int FUNCTION_FONT_SIZE = 36;

boolean EQUALIZE_AXES = true;
boolean SHOW_GRID = true;

void createGraph() {
  PWFunction pwf = new PWFunction();
  FunctionPiece piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return x;
    }
  }
  , 1, 2, true, true);
  pwf.addPiece(piece);

  piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return 4-x;
    }
  }
  , 2, 3, true, true);
  pwf.addPiece(piece);

  piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return x - 2;
    }
  }
  , 3, 4, true, true);
  pwf.addPiece(piece);


  piece = new FunctionPiece(new Function() {
    public double value(double x) {
      return 2;
    }
  }
  , 4, 6, true, true);
  pwf.addPiece(piece);

  graph.addFunction(pwf );
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

  graph.addFunction(f);
}

//Utility functions

void createFunctionAndFirstTwoDerivatives(Function f, String fLabel, String f1Label, String f2Label) {
  //Create and add Functions
  f.label(fLabel);

  Function g = new NumericalDerivative(f);
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
