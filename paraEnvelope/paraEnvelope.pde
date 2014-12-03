float minX = -4;
float minY = -4;
float maxX = 4;
float maxY = 4;
float dX = 20;
float stepSize = .3;
boolean axisIsVisible = false;

Functor functor;
Functor parabola = new Parabola();
Functor cubic = new Cubic();
Functor exponential = new Exponential();
Functor sine = new Sine();
Functor cotangent = new Cotangent();
Functor cosecant = new Cosecant();
interface JavaScript {
  void showValues(float s);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(360, 360);
  functor = parabola;
}

void draw() {
  background(255);
  if (javascript!=null) 
    javascript.showValues(stepSize);
  translate(width/2, height/2);
  stroke(255, 0, 0);
  strokeWeight(1);
  if (axisIsVisible) {
    drawXAxis();
    drawYAxis();
  }
  stroke(0, 255.0*stepSize+10.0);
  float nextX = minX;
  while (nextX < maxX) {
    float slope = functor.slope(nextX);
    float y = functor.value(nextX);
    float x0 = mapXToScreen(nextX-dX, minX, maxX);
    float y0 = mapYToScreen(-slope*dX+y, minY, maxY);
    float x1 = mapXToScreen(nextX+dX, minX, maxX);
    float y1 = mapYToScreen(slope*dX+y, minY, maxY);
    line(x0, y0, x1, y1);
    nextX =  nextX + stepSize;
  }
}

void setFunctor(String f) {
  //  println(f);
  if (f.equals("Parabola")) {
    functor = parabola;
  } 
  else if (f.equals("Cubic")) {
    functor = cubic;
  } 
  else if (f.equals("Exponential")) {
    functor = exponential;
  } 
  else if (f.equals("Sine")) {
    functor = sine;
  } 
  else if (f.equals("Cotangent")) {
    functor = cotangent;
  } 
  else {
    functor = cosecant;
  }
}

void changeFrame(float newMinX, float newMaxX, float newMinY, float newMaxY) {
    minX = newMinX * 1.0;
    maxX = newMaxX * 1.0;
    minY = newMinY * 1.0;
    maxY = newMaxY * 1.0;
}

void setStepSize(float d) {
  stepSize = d * 1.0;
}

void showAxis(boolean show) {
  axisIsVisible = show;
}

void drawXAxis() {
  drawLine(minX, 0, maxX, 0);
}

void drawYAxis() {
  drawLine(0, minY, 0, maxY);
}

void drawLine(float x0, float y0, float x1, float y1) {
  float mappedX0 = map(x0, minX, maxX, -width/2, width/2);
  float mappedY0 = map(y0, minY, maxY, -height/2, height/2);
  float mappedX1 = map(x1, minX, maxX, -width/2, width/2);
  float mappedY1 = map(y1, minY, maxY, -height/2, height/2);
  line(mappedX0, mappedY0, mappedX1, mappedY1);
}

float mapXToScreen(float x, float minx, float maxx) {
  return (x - minx)/(maxx - minx)* width - width/2;
}

float mapYToScreen(float y, float miny, float maxy) {
  return height * 0.5 -(y - miny)/(maxy - miny)* height;
}

abstract class Functor {
  abstract float value(float x);
  abstract float slope(float x);
}

class Parabola extends Functor {
  public float value(float x) {
    return x * x;
  }
  public float slope(float x) {
    return 2 * x;
  }
}

class Cubic extends Functor {
  public float value(float x) {
    return x * x * x;
  }
  public float slope(float x) {
    return 3 * x * x;
  }
}

class Sine extends Functor {
  public float value(float x) {
    return sin(x);
  }
  public float slope(float x) {
    return cos(x);
  }
}

class Exponential extends Functor {
  public float value(float x) {
    return exp(x);
  }
  public float slope(float x) {
    return exp(x);
  }
}

class Cotangent extends Functor {
  public float value(float x) {
    return cos(x)/sin(x);
  }
  public float slope(float x) {
    return -1/(sin(x)*sin(x));
  }
}

class Cosecant extends Functor {
  public float value(float x) {
    return 1/sin(x);
  }
  public float slope(float x) {
    return -cos(x)/(sin(x)*sin(x));
  }
}
