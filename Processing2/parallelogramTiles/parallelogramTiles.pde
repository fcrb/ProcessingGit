import processing.pdf.*;

void setup() {
  size(72 * 24, 72 * 12, PDF, "parallelogramTiles.pdf");
  background(255);
  strokeWeight(0.036);
  
  float singleTileSide = 72.0;
  float rowSep = singleTileSide * sqrt(3)/2;
  float y = 10;
  while(y < height) {
    line(0,y,width,y);
    y += rowSep;
  }
  rotate(PI/3);
  y = -height * 2;
  while(y < height * 2) {
    line(0,y,width,y);
    y += rowSep * 2;
  }
}
