/*
    TO DO: 
 - add  numerical 1st and second derivative
 
 */
Graph graph;

PFont baseFont, italicFont;
double X_MIN_ORIGINAL, X_MAX_ORIGINAL, Y_MIN_ORIGINAL, Y_MAX_ORIGINAL;
void setup() {
  //  int w = (int) (WIDTH_INCHES * 72);
  //  int h = (int) (HEIGHT_INCHES * 72);
  size(WIDTH_PIXELS, HEIGHT_PIXELS);

  graph = new Graph();
  //  noLoop();
  //TODO -- don't draw unless something has changed
  X_MIN_ORIGINAL = X_MIN;
  X_MAX_ORIGINAL = X_MAX;
  Y_MIN_ORIGINAL = Y_MIN;
  Y_MAX_ORIGINAL = Y_MAX;
  normalizeMinsAndMaxes();
  beginRecord(PDF, FILE_NAME + ".pdf");
  textMode(SHAPE);
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
  background(255);
  handleMousePress();
  graph.draw();
  endRecord();
}

double zoomMultiplier = 1.05;
void keyPressed() {
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
    double xDragOffset = (X_MAX - X_MIN) * (mouseX - mouseXStartDrag) / width;
    X_MIN -= xDragOffset;
    X_MAX -= xDragOffset;
    double yDragOffset = (Y_MAX - Y_MIN) * (mouseY - mouseYStartDrag) / height;
    Y_MIN += yDragOffset;
    Y_MAX += yDragOffset;
    mouseXStartDrag = mouseX;
    mouseYStartDrag = mouseY;
  }

  abstract class Function {
    int colr = color(0);
    float strokeWt = 1.0;
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
    void strokeWeight(float sw) {
      strokeWt = sw;
    }
    //THIS SHOULD BE OVERRIDDEN
    double value(double x) {
      return 0;
    }
  }

  class NumericalDerivative extends Function {
    Function f;
    NumericalDerivative(Function f_) {
      f = f_;
    }

    final double value(double x) {
      double h = (X_MAX - X_MIN) / width ;
      return (f.value(x+ h) - f.value(x-h))/h * 0.5;
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
      if (SHOW_GRID) {
        drawGridLines();
        drawGridLabels();
      }
      drawPoints();
      drawFunctions();
    }

    void drawFunctions() {
      double dx = (X_MAX - X_MIN) / width * .1;
      int functionIndex = 0;
      for (Function f : functions) {
        stroke(f.colr);
        strokeWeight(f.strokeWt);
        noFill();
        beginShape();
        boolean shapeIsStarted = true;
        double xDragOffset = 0;
        if (mouseDragging) {
          xDragOffset = (X_MAX - X_MIN) * (mouseX - mouseXStartDrag) / width;
        }
        double x = X_MIN + xDragOffset;
        while (x < X_MAX + xDragOffset) {
          double y = f.value(x);
          if (!Double.isNaN(y)) {
            if (!shapeIsStarted) {
              beginShape();
              shapeIsStarted = true;
            }
            vertex( xToScreenX(x), yToScreenY(y));
          } else {
            endShape();
            shapeIsStarted = false;
          }
          x += dx;
        }
        if (shapeIsStarted)
          endShape();

        //draw function label
        //      float colorScalar = 0.8;
        //      int fontColor = color(red(f.colr) * colorScalar, green(f.colr) * colorScalar, blue(f.colr)* colorScalar);
        //      fill(fontColor);
        //      textFont(italicFont);
        //      textSize(FUNCTION_FONT_SIZE);
        //      double labelFractionAcrossScreen = (++functionIndex * 1.0) / (functions.size() + 1);
        //      double xLabel = X_MIN + (X_MAX-X_MIN) * labelFractionAcrossScreen;
        //      double yLabel = f.value(xLabel);
        //      text(f.label_, xToScreenX(xLabel), yToScreenY(yLabel));
      }
      //draw function label
      for (Function f : functions) {
        float colorScalar = 0.8;
        int fontColor = color(red(f.colr) * colorScalar, green(f.colr) * colorScalar, blue(f.colr)* colorScalar);
        fill(fontColor);
        textFont(italicFont);
        textSize(FUNCTION_FONT_SIZE);
        double labelFractionAcrossScreen = (++functionIndex * 1.0) / (functions.size() + 1);
        double xLabel = X_MIN + (X_MAX-X_MIN) * labelFractionAcrossScreen;
        double yLabel = f.value(xLabel);
        text(f.label_, xToScreenX(xLabel), yToScreenY(yLabel));
      }
    }

    void drawPoints() {
      noStroke();
      for (Point p : points) {
        fill(p.colr);
        ellipse(xToScreenX(p.x), yToScreenY(p.y ), 5, 5);
      }
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
      stroke(240);
      strokeWeight(0.5);

      //draw vertical lines
      double GRID_INTERVAL =  gridInterval();
      double xLine = (1 + (int) (X_MIN / GRID_INTERVAL)) * GRID_INTERVAL;
      int numLines = (int) ((X_MAX - X_MIN) / GRID_INTERVAL + 1);
      for (int i = 0; i < numLines; ++i) {
        float xScreen = xToScreenX(xLine);
        line(xScreen, -1000000, xScreen, 1000000);
        xLine += GRID_INTERVAL;
      }
      //draw horizontal lines
      double yLine = (1 + (int) (Y_MIN / GRID_INTERVAL)) * GRID_INTERVAL;
      numLines = (int) ((Y_MAX - Y_MIN) / GRID_INTERVAL + 1);
      for (int i = 0; i < numLines; ++i) {
        float yScreen = yToScreenY(yLine);
        line(-100000, yScreen, 100000, yScreen);
        yLine += GRID_INTERVAL;
      }
    }

    float xToScreenX(double x) {
      return (float)((x - X_MIN) / (X_MAX - X_MIN) * width);
    }

    float yToScreenY(double y) {
      return (float)((Y_MAX - y) / (Y_MAX - Y_MIN) * height);
    }

    void drawGridLabels() {
      textFont(baseFont);
      float textHeight = NUMBER_FONT_SIZE;
      textSize(textHeight);
      fill(150);

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
