class Graph {
  float xMin, xMax, yMin, yMax;
  float gridInterval;
  ArrayList<Functor> functors = new ArrayList<Functor>();

  Graph(float xMin_, float xMax_, float yMin_, float interval) {
    xMin = xMin_;
    xMax = xMax_;
    yMin = yMin_;
    yMax = yMin + (xMax - xMin) * height/width;
    gridInterval = interval;
  }
  
  void addFunctor(Functor f) {
    functors.add(f);
  }

  void draw() {
    drawGridLines();
    drawGridLabels(12);
    drawFunctions();
  }
  
  void drawFunctions() {
    stroke(0);
    strokeWeight(1);
    float dx = (xMax - xMin) / width * 2;
    for (Functor f : functors) {
      float xPrev = xMin - dx;
      float yPrev = f.value(xPrev);
      for (int i = 0; i < width; ++i) {
        float x = xMin + i * dx;
        float y = f.value(x);
        line(xToScreenX(xPrev),yToScreenY(yPrev), xToScreenX(x), yToScreenY(y));
        xPrev = x;
        yPrev = y;
      }
    }
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
