class EllipticGraph {
  float xMin, xMax, yMin, yMax;
  float gridInterval;
  //  float a30, a21, a12, a03, a20, a11, a02, 
  float[][] a;//coefficients of elliptic, row is x exponent, col is y exponent

  Graph(float xMin_, float xMax_, float yMin_, float interval, float[][] a_) {
    xMin = xMin_;
    xMax = xMax_;
    yMin = yMin_;
    yMax = yMin + (xMax - xMin) * height/width;
    gridInterval = interval;
    a = a_;
  }

  void draw() {
    drawGridLines();
    drawGridLabels(12);
    drawElliptic();
  }

  void drawElliptic() {
    float dx = (xMax - xMin) / width * 2;
    for (int i = 0; i < width; ++i) {
      float x = xMin + i * dx;
      CubicEquation cubic = cubic(x);
      float[] yValues = cubic.roots;
      for(float y : yValues) {
        point(x, y);
      }
    }
  }

  CubicEquation cubic(float x) {
    float a3 = a[0][3];
    float a2 = a[0][2]+ x * a[1][2];
    float a1 = a[0][1]+ x * ( a[1][1] + x * a[2][1]);
    float a1 = a[0][0]+ x * ( a[1][0] + x * (a[2][0] + x * a[3][0]));
    return new CubicEquation(a3, a2, a1, a0);
  }

  void setGridInterval(float interval) {
    gridInterval = interval;
  }

  void drawGridLines() {
    stroke(240);
    strokeWeight(1);

    //draw vertical lines
    float xLine = (1 + (int) (xMin / gridInterval)) * gridInterval;
    int numLines = (int) ((xMax - xMin) / gridInterval + 1);
    for (int i = 0; i < numLines; ++i) {
      float xScreen = xToScreenX(xLine);
      line(xScreen, -1000000, xScreen, 1000000);
      xLine += gridInterval;
    }
    //draw horizontal lines
    float yLine = (1 + (int) (yMin / gridInterval)) * gridInterval;
    numLines = (int) ((yMax - yMin) / gridInterval + 1);
    for (int i = 0; i < numLines; ++i) {
      float yScreen = yToScreenY(yLine);
      line(-1000000, yScreen, 1000000, yScreen);
      yLine += gridInterval;
    }
  }

  float xToScreenX(float x) {
    return (x - xMin) / (xMax - xMin) * width;
  }

  float yToScreenY(float y) {
    return (yMax - y) / (yMax - yMin) * height;
  }

  void drawGridLabels(float textHeight) {
    textSize(textHeight);
    fill(150);


    //draw x-axis labels
    float xLine = ( (int) (xMin / gridInterval) - 1) * gridInterval ;
    int numLines = (int) ((xMax - xMin) / gridInterval + 2);
    for (int i = 0; i < numLines; ++i) {
      float xScreen = xToScreenX(xLine);
      String xAxisLabel = ""+xLine;
      text(xAxisLabel, xScreen - textWidth(xAxisLabel)/2, yToScreenY(0 ) + textHeight/2);
      xLine += gridInterval;
    }

    //draw y-axis labels
    float yLine = ((int) (yMin / gridInterval) - 1) * gridInterval;
    numLines = (int) ((yMax - yMin) / gridInterval + 2);
    for (int i = 0; i < numLines; ++i) {
      float yScreen = yToScreenY(yLine);
      String yAxisLabel = ""+yLine;
      text(yAxisLabel, xToScreenX(0) - textWidth(yAxisLabel)/2, yScreen + textHeight/2);
      yLine += gridInterval;
    }
  }
}
