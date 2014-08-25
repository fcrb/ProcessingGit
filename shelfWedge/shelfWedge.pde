import processing.pdf.*;
/*
The idea here is to create a library for quickly 
 creating cut & fold patterns. 
 */
float w = 3.5;
float h = 1;
float d = 4;

float c = dist(0, 0, h, d);
float inchesPerUnit = 1;
float xShift = (h + h * d /c) * 1.1;
float yShift = -h * 1.1;
int cutCount = 0;
boolean showLabels = false;
float HAIRLINE_WEIGHT = 0.072;
float ETCH_WEIGHT = 2;

void setup() {
  size(576, 792);//, PDF, "boxPattern.pdf");
  //  paperWidth = 10.5 * 72;
  //  inset = (width - paperWidth) * 0.5;

  background(255);

  cut(-h, (d-h)* h /d, 0, h);//0
  cut(-h, (d-h)* h /d, -h, 0);
  cut(0, 0, -h, 0);
  fold(0, -d, 0, h);//3
  cut(w, h, 0, h);
  cut(w, h, w+h, (d-h)*h/d);
  cut(w+h, 0, w+h, (d-h)*h/d);
  cut(w+h, 0, w, 0);
  fold(0, 0, w, 0);//8
  fold(w, h, w, -d);//9
  fold(w, -d, w+h, 0);
  fold(w, -d, 0, -d);
  fold(-h, 0, 0, -d);
  cut(0, -d, 0, -d-c-h);//13
  cut(w, -d, w, -d-c-h);
  cut(0, -d-c-h, w, -d-c-h);
  fold(0, -d-c, w, -d-c);

  //left side tab
  cut(-h-h * d/c, -h *h/c, -h, 0);
  cut(-h-h * d/c, -h *h/c, -h *d/c, -d - h*h/c);
  cut(-h *d/c, -d - h*h/c, 0, -d);

  //right side tab
  cut(w + h, 0, w + h + h * d/c, -h * h /c);
  cut(w + h * d /c, -d-h*h/c, w + h + h * d/c, -h * h /c);
  cut(w + h * d /c, -d-h*h/c, w, -d);
}

void cut(float x0, float y0, float x1, float y1) {
  stroke(0);
  strokeWeight(HAIRLINE_WEIGHT);
  cutFoldDefault(x0, y0, x1, y1);
}

void fold(float x0, float y0, float x1, float y1) {
  stroke(0);
  strokeWeight(ETCH_WEIGHT);
  cutFoldDefault(x0, y0, x1, y1);
}

void cutFoldDefault(float x0, float y0, float x1, float y1) {
  line(mapX(x0), mapY(y0), mapX(x1), mapY(y1));
  if (showLabels) {
  fill(255, 0, 0);
    text(""+cutCount, mapX((x0+x1)/2), mapY((y0+y1)/2));
  } 
  ++cutCount;
}

float mapX(float x) {
  return (x + xShift) * inchesPerUnit * 72;
}

float mapY(float y) {
  return -(y + yShift) * inchesPerUnit * 72;
}
