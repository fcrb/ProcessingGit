/* The mask is animage where WHITE indicates pixels //<>//
that should become WHITE, BLACK where pixels should turn
BLACK, and GREEN where pixels should be left alone.
*/

int WHITE = color(255);
int GREEN = color(0, 255, 0);
int BLACK = color(0);

void setup() {
  size(400, 400);

  PGraphics pg = heartMask(0.9);
  image(pg,0,0);
}

PGraphics heartMask(float thickness) {
  float outerWidthMultiple = 0.28;
  float innerWidthMultiple = outerWidthMultiple * (1 - thickness);
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.noSmooth();
  pg.rectMode(CENTER);
  pg.background(255);
  pg.stroke(BLACK);
  pg.fill(BLACK);
  float radius = width * outerWidthMultiple;
  float diameter = radius * 2;  
  pg.translate(width / 2, height * 0.55);
  pg.strokeWeight(2);
  float xCenter = -radius / sqrt(2);
  pg.arc(xCenter, xCenter, diameter, diameter, 3 * PI /4, 7 * PI / 4);
  pg.arc(-xCenter, xCenter, diameter, diameter, 5 * PI /4, 9 * PI / 4);
  pg.rotate(PI/4);
  pg.rect(0, 0, diameter, diameter);
  pg.rotate(-PI/4);
  pg.stroke(GREEN);
  pg.fill(GREEN);
  radius = width * innerWidthMultiple;
  diameter = radius * 2;  
  pg.arc(xCenter, xCenter, diameter, diameter, 3 * PI /4, 7 * PI / 4);
  pg.arc(-xCenter, xCenter, diameter, diameter, 5 * PI /4, 9 * PI / 4);
  pg.rotate(PI/4);
  float delta = width * (outerWidthMultiple - innerWidthMultiple);
  pg.rect(-delta/2, 0, diameter + delta, diameter);
  pg.rotate(-PI/2);
  pg.rect(delta/2, 0, diameter + delta, diameter);
  pg.endDraw();
  return pg;
}
