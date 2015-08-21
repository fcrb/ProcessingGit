import processing.pdf.*;

float w = 6;
float h = 2.6;

float inchesPerUnit = 1;
float xShift = h * 0.02;
float yShift = -h * 1.05;
int cutCount = 0;
boolean showLabels = false;
float EDGE_WEIGHT = 1;
float FOLD_WEIGHT = 1;
float DASH_LENGTH = w * 0.03;

void setup() {
  size(440, 200, PDF, "foldingDollarBill_fold3.pdf");

  background(255);

  //first fold
//  edge(0, 0, 0, h);//0
//  edge(w, h, 0, h);
//  edge(w, h, w, 0);
//  edge(0, 0, w, 0);
//  valley(0, h/2, w, h/2);
  
  //second fold
//  edge(0, 0, h / sqrt(3), h);//0
//  edge(w, h, h / sqrt(3), h);
//  edge(h * sqrt(3) / 2, h/2, h / sqrt(3), h);
//  edge(h * sqrt(3) / 2, h/2, 0,0);
//  edge(w, h, w, 0);
//  edge(0, 0, w, 0);
//  valley(h * sqrt(3) / 2, h/2, w, h/2);

  //third fold
  edge(w, h, h / sqrt(3), h);
  edge(h *  2/sqrt(3), 0, h / sqrt(3), h);
  edge(w, h, w, 0);
  edge(h *  2/sqrt(3), 0, w, 0);
  edge(h *  2/sqrt(3), 0, h *  (2/sqrt(3) + 0.5) , h);
  valley( h *  (2/sqrt(3) + 0.25), h/2, w, h/2);
}

void edge(float x0, float y0, float x1, float y1) {
  stroke(0);
  strokeWeight(EDGE_WEIGHT);
  line(mapX(x0), mapY(y0), mapX(x1), mapY(y1));
  addLabel(x0, y0, x1, y1);
}

void mountain(float x0, float y0, float x1, float y1) {
  stroke(0);
  strokeWeight(FOLD_WEIGHT);
  line(mapX(x0), mapY(y0), mapX(x1), mapY(y1));
  addLabel(x0, y0, x1, y1);
}

void valley(float x0, float y0, float x1, float y1) {
  stroke(0);
  strokeWeight(FOLD_WEIGHT);
  float numDashes = dist(x0, y0, x1, y1) / DASH_LENGTH;
  float x = x0;
  float y = y0;
  float xStep = (x1 - x0) / numDashes / 2;
  float yStep = (y1 - y0) / numDashes / 2;
  for (int i = 0; i < numDashes; ++i) {
    float xStop, yStop;
    if (i < numDashes - 1) {
      xStop = (x + xStep);
      yStop = (y + yStep);
    } 
    else {
      xStop = x1;
      yStop = y1;
    }
    line(mapX(x), mapY(y), mapX(xStop), mapY(yStop));
    x += xStep * 2;
    y += yStep * 2;
  }
  addLabel(x0, y0, x1, y1);
}

void addLabel(float x0, float y0, float x1, float y1) {
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
