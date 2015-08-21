import processing.pdf.*;
int numCircles;

void setup() {
  size(1000, 1000);//, PDF, "overlappingCircles.pdf");

  PGraphics pgMerge =  ellipseGraphics(0,0);
  numCircles= 12;
  for (int i = 0; i < numCircles; ++i) {
    float ctrRadius = width /6 ;
    pgMerge = mergeGraphics(pgMerge, nextEllipse(i, ctrRadius));
  }
  numCircles= 8;
  for (int i = 0; i < numCircles; ++i) {
    float ctrRadius = width /3 ;
    pgMerge = mergeGraphics(pgMerge, nextEllipse(i, ctrRadius));
  }
  image(pgMerge, 0, 0);
}

PGraphics nextEllipse(int n, float ctrRadius) {
  float angle = 2 * PI * n / numCircles;
  return  ellipseGraphics(ctrRadius * cos(angle) , ctrRadius * sin(angle));
}

PGraphics ellipseGraphics(float x, float y) {
  PGraphics pg = createGraphics(width, height);

  pg.beginDraw();
  pg.noStroke();
  pg.background(0);
  pg.translate(width/2, height/2);
  pg.fill(255);
  pg.ellipse(x, y, width/3, width/3);
  pg.endDraw();
  return pg;
}

PGraphics mergeGraphics(PGraphics pg, PGraphics pg2) {
  PGraphics pgMerge = createGraphics(width, height);
  pgMerge.beginDraw();
  for (int row = 0; row < width; ++row) {
    for (int column = 0; column <  height; ++column) {
      if (pg.get(row, column)==pg2.get(row, column)) {
        //same color, so make it black
        pgMerge.set(row, column, color(0));
      } 
      else {
        pgMerge.set(row, column, color(255));
      }
    }
  }
  pgMerge.endDraw();
  return pgMerge;
}
