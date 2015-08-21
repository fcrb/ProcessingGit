void setup() {
  size(1024, 1024);

  int numCircles = 6;
  PGraphics pgMerge = randomEllipse();
  for (int i = 1; i < numCircles; ++i) {
    pgMerge = mergeGraphics(pgMerge, randomEllipse());
  }
  image(pgMerge, 0, 0);
}

PGraphics randomEllipse() {
  return  ellipseGraphics(random(-width/3, width/3), random(-height/4, height/4));
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
