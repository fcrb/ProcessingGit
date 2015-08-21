Graph graph;

PFont baseFont, italicFont;
double X_MIN_ORIGINAL, X_MAX_ORIGINAL, Y_MIN_ORIGINAL, Y_MAX_ORIGINAL;
boolean needRedraw = true;

void setup() {
  size(WIDTH_PIXELS, HEIGHT_PIXELS);

  graph = new Graph();
  X_MIN_ORIGINAL = X_MIN;
  X_MAX_ORIGINAL = X_MAX;
  Y_MIN_ORIGINAL = Y_MIN;
  Y_MAX_ORIGINAL = Y_MAX;
  normalizeMinsAndMaxes();
  beginRecord(PDF, "pdf/"+FILE_NAME + ".pdf");
  baseFont = createFont("cmunrm.otf", NUMBER_FONT_SIZE);//"CMUSerif-Roman", 12);
  italicFont = createFont("cmunti.otf", NUMBER_FONT_SIZE);//("CMUSerif-Italic", 12);
  textFont(baseFont);
  createGraph();
} 

void normalizeMinsAndMaxes() {
  if (X_MIN >= X_MAX) {
    X_MAX = X_MIN + 1;
  }
  if (Y_MIN >= Y_MAX) {
    Y_MAX = Y_MIN + 1;
  }
  if (EQUALIZE_AXES) {
    Y_MAX = Y_MIN + (X_MAX - X_MIN) * height / width;
  }
}

void draw() {
  handleMousePress();
  if (!needRedraw) {
    return;
  }
  background(255);
  graph.draw();
  endRecord();
  needRedraw = false;
}

double zoomMultiplier = 1.05;
int labelPositionMode = 0;

void keyPressed() {
  needRedraw = true;
  switch(key) {
  case 'p':
    beginRecord(PDF, FILE_NAME + ".pdf");
    background(255);
    graph.draw();
    endRecord();
    break;

  case '+':
    zoom(1/zoomMultiplier);
    break;

  case '-':
    zoom(zoomMultiplier);
    break;

  case '0':
    X_MIN = X_MIN_ORIGINAL;
    X_MAX = X_MAX_ORIGINAL;
    Y_MIN = Y_MIN_ORIGINAL;
    Y_MAX = Y_MAX_ORIGINAL;
    normalizeMinsAndMaxes();
    break;

  case 'l':
    labelPositionMode += 1;
    labelPositionMode %= 2;
    break;

  default:
    needRedraw = false;
  }
}

void zoom(double multiplier) {
  double deltaMultiplier = (multiplier - 1) * 0.5;
  double xWidthDelta = (X_MAX - X_MIN) * deltaMultiplier;
  X_MIN -= xWidthDelta;
  X_MAX += xWidthDelta;
  double yWidthDelta = (Y_MAX - Y_MIN) * deltaMultiplier;
  Y_MIN -= yWidthDelta;
  Y_MAX += yWidthDelta;
}

boolean mouseDragging = false;
float mouseXStartDrag, mouseYStartDrag;
void handleMousePress() {
  if (!mousePressed) { 
    mouseDragging = false; 
    return;
  }
  if (!mouseDragging) {
    mouseDragging = true;
    mouseXStartDrag = mouseX;
    mouseYStartDrag = mouseY;
  }
  needRedraw = true;
  double xDragOffset = (X_MAX - X_MIN) * (mouseX - mouseXStartDrag) / width;
  X_MIN -= xDragOffset;
  X_MAX -= xDragOffset;
  double yDragOffset = (Y_MAX - Y_MIN) * (mouseY - mouseYStartDrag) / height;
  Y_MIN += yDragOffset;
  Y_MAX += yDragOffset;
  mouseXStartDrag = mouseX;
  mouseYStartDrag = mouseY;
}

float xToScreenX(double x) {
  return (float)((x - X_MIN) / (X_MAX - X_MIN) * width);
}

float yToScreenY(double y) {
  return (float)((Y_MAX - y) / (Y_MAX - Y_MIN) * height);
}

abstract class Function {
  int colr = color(0);
  float strokeWt = 1;
  String label_="";

  void label(String lbl) {
    label_ = lbl;
  }
  void stroke(int r, int g, int b) {
    colr = color(r, g, b);
  }
  void stroke(int r, int g, int b, int a) {
    colr = color(r, g, b, a);
  }
  void stroke(int grayScale) {
    colr = color(grayScale, grayScale, grayScale);
  }
  void stroke(int grayScale, int a) {
    stroke(grayScale, grayScale, grayScale, a);
  }
//  void strokeWeight(float sw) {
//    strokeWt = sw;
//  }

  void drawFunctionOnInterval(double a, double b) {    
   println("Hey"); 
    stroke(color(255,0,0));//this.colr);
    strokeWeight(FUNCTION_STROKE_WEIGHT);
//    noFill();
    beginShape();
    boolean shapeIsStarted = true;
    double xDragOffset = 0;
    if (mouseDragging) {
      xDragOffset = (X_MAX - X_MIN) * (mouseX - mouseXStartDrag) / width;
    }
    double x = a + xDragOffset;
    double dx = (X_MAX - X_MIN) / width * .1;
    while (x < b + xDragOffset) {
      double y = value(x);
      if (!Double.isNaN(y)) {
        if (!shapeIsStarted) {
          beginShape();
          shapeIsStarted = true;
        }
        //        println(""+xToScreenX(x)+","+yToScreenY(y));
        vertex( xToScreenX(x), yToScreenY(y));
      } else {
        endShape();
        shapeIsStarted = false;
      }
      x += dx;
    }
    if (shapeIsStarted) {
      endShape();
    }
  }

  void drawFunction() {     
    drawFunctionOnInterval(X_MIN, X_MAX);
  }

  void drawLabel(int functionIndex, int numberOfFunctions) {     
    float colorScalar = 0.8;
    int fontColor = color(red(colr) * colorScalar, green(colr) * colorScalar, blue(colr)* colorScalar);
    fill(fontColor);
    textFont(italicFont);
    textSize(FUNCTION_FONT_SIZE);

    double labelFractionAcrossScreen;
    switch(labelPositionMode) {
    case 0:
      labelFractionAcrossScreen =  (functionIndex * 1.0) / (numberOfFunctions + 1);
      break;

    default:
      labelFractionAcrossScreen = 0.5;
    }
    double xLabel = X_MIN + (X_MAX-X_MIN) * labelFractionAcrossScreen;
    double yLabel = value(xLabel);
    text(label_, xToScreenX(xLabel) - textWidth(label_)/2, yToScreenY(yLabel) + FUNCTION_FONT_SIZE/2);
  }

  //THIS SHOULD BE OVERRIDDEN
  double value(double x) {
    return x*x;
  }
}

class FunctionPiece {
  double a, b;
  boolean leftClosed, rightClosed;
  Function f;

  FunctionPiece(Function f_, double a_, double b_, boolean includeLeft, boolean includeRight) {
    f = f_; 
    a = a_; 
    b = b_;
    leftClosed = includeLeft;
    rightClosed = includeRight;
  }

  void draw() {
    f.drawFunctionOnInterval(a, b);
    float openDiameter = width/80.0;
    fill(255);
//    stroke(width/320.0);
    if (!leftClosed) {
      ellipse(xToScreenX(a), yToScreenY(f.value(a)), openDiameter, openDiameter);
    }
    if (!rightClosed) {
      ellipse(xToScreenX(b), yToScreenY(f.value(b)), openDiameter, openDiameter);
    }
  }
}

class PWFunction extends Function {
  ArrayList<FunctionPiece> pieces = new ArrayList<FunctionPiece>();

  void addPiece(FunctionPiece piece) {
    pieces.add(piece);
  }

  void drawFunction() {     
    for (FunctionPiece piece : pieces) {
      piece.draw();
    }
  }
}

class NumericalDerivative extends Function {
  Function f;
  NumericalDerivative(Function f_) {
    f = f_;
  }

  final double value(double x) {
    double h = (X_MAX - X_MIN) / width ;
    return (value(x+ h) - value(x-h))/h * 0.5;
  }
}

class Point {
  double x, y;
  int colr = color(0);
  Point(double x_, double y_) {
    x = x_; 
    y= y_;
  }

  void fill(int r, int g, int b) {
    colr = color(r, g, b);
  }
  void fill(int r, int g, int b, int a) {
    colr = color(r, g, b, a);
  }
  void fill(int grayScale) {
    colr = color(grayScale, grayScale, grayScale);
  }
  void fill(int grayScale, int a) {
    stroke(grayScale, grayScale, grayScale, a);
  }
}


class Graph {
  ArrayList<Function> functions = new ArrayList<Function>();
  ArrayList<Point> points = new ArrayList<Point>();

  void addFunction(Function f) {
    functions.add(f);
  }

  void addPoint(Point p) {
    points.add(p);
  }

  void draw() {
    drawFunctions();
    drawGridLines();
    drawGridLabels();
    drawPoints();
  }

  void drawFunctions() {
    
    double dx = (X_MAX - X_MIN) / width * .1;
    for (Function f : functions) {      
      f.drawFunction();
    }
    //draw function label
    int functionIndex = 0;
    for (Function f : functions) {
      f.drawLabel(++functionIndex, functions.size());
    }
  }

  void drawPoints() {
    //    pushMatrix();
    //    noStroke();
    for (Point p : points) {
      fill(p.colr);
      ellipse(xToScreenX(p.x), yToScreenY(p.y ), 5, 5);
    }
    //    popMatrix();
  }

  double gridInterval() {
    double interval  = 1;
    double exactInterval = (X_MAX - X_MIN ) / MAX_INTERVALS_ON_X_AXIS;
    double[] multipliers = new double[] {
      2, 2.5, 2
    };
    int multiplierIndex = 0;
    if (interval > exactInterval) {
      while (interval/ multipliers[multiplierIndex] > exactInterval) {
        interval /= multipliers[multiplierIndex++];
        multiplierIndex %= multipliers.length;
      }
    } else {
      while (interval < exactInterval) {
        interval *= multipliers[multiplierIndex++];
        multiplierIndex %= multipliers.length;
      }
    }
    return interval;
  }

  void drawGridLines() {
    stroke(127);
    strokeWeight(0.5);

    //draw vertical lines
    double GRID_INTERVAL =  gridInterval();
    int xGridTicks = (int) (X_MIN / GRID_INTERVAL);
    double xLine = xGridTicks * GRID_INTERVAL;
    int numLines = (int) ((X_MAX - X_MIN) / GRID_INTERVAL + 1);
    for (int i = 0; i <= numLines; ++i) {
      float xScreen = xToScreenX(xLine);
      if ( SHOW_GRID ||(i + xGridTicks == 0))
        line(xScreen, -1000000, xScreen, 1000000);
      xLine += GRID_INTERVAL;
    }
    //draw horizontal lines
    int yGridTicks = (int) (Y_MIN / GRID_INTERVAL);
    double yLine =  yGridTicks * GRID_INTERVAL;
    numLines = (int) ((Y_MAX - Y_MIN) / GRID_INTERVAL + 1);
    for (int i = 0; i <= numLines; ++i) {
      float yScreen = yToScreenY(yLine);
      if (SHOW_GRID ||(i + yGridTicks == 0))
        line(-100000, yScreen, 100000, yScreen);
      yLine += GRID_INTERVAL;
    }
  }

  void drawGridLabels() {
    textFont(baseFont);
    float textHeight = NUMBER_FONT_SIZE;
    textSize(textHeight);
    fill(100);

    //draw x-axis labels
    double GRID_INTERVAL =  gridInterval();
    double xLine = ( (int) (X_MIN / GRID_INTERVAL) - 1) * GRID_INTERVAL ;
    int numLines = (int) ((X_MAX - X_MIN) / GRID_INTERVAL + 2);
    for (int i = 0; i < numLines; ++i) {
      float xScreen = xToScreenX(xLine);
      String xAxisLabel = nf((float) xLine, 1, 0);
      text(xAxisLabel, xScreen - textWidth(xAxisLabel)/2, yToScreenY(0 ) + textHeight/2);
      xLine += GRID_INTERVAL;
    }

    //draw y-axis labels
    double yLine = ((int) (Y_MIN / GRID_INTERVAL) - 1) * GRID_INTERVAL;
    numLines = (int) ((Y_MAX - Y_MIN) / GRID_INTERVAL + 2);
    for (int i = 0; i < numLines; ++i) {
      float yScreen = yToScreenY(yLine);
      String yAxisLabel = nf((float)yLine, 1, 0);
      text(yAxisLabel, xToScreenX(0) - textWidth(yAxisLabel)/2, yScreen + textHeight/2);
      yLine += GRID_INTERVAL;
    }
  }
}
