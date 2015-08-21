import processing.pdf.*;

int NUMBER_ZIGS = 6;
int SQUARE_WIDTH = 72 * 8;
float sideLength =  0.995 * (SQUARE_WIDTH * 2 / sqrt(3) / NUMBER_ZIGS);

void setup() {
  size(SQUARE_WIDTH, SQUARE_WIDTH, PDF, "miuraFolding.pdf");

  background(255);
  translate(1,1);
  strokeWeight(72 /300.0);
  stroke(0);
  int numRows = (int) (height / sideLength + 1);
  float sideProjection = sideLength * sqrt(3) / 2;

  //vertical lines
  float yBottom = (numRows - 1) * sideLength ;
  for (int i = 0; i <= NUMBER_ZIGS; ++i) {
    float x =  i * sideProjection;
    line(x, 0, x, yBottom);
  }

  //border
  line(0, 0, NUMBER_ZIGS * sideProjection, 0);

  //horizontal up & downs
 float yOffset = 3*sideLength/4;
  for (int row = 0; row < numRows; ++row) {
    float y = row * sideLength + yOffset;
    for (int i = 0; i < NUMBER_ZIGS / 2; ++i) {
      line(i * 2 * sideProjection, y, (i * 2 +1) * sideProjection, y - sideLength / 2);
      line((i * 2 +1) * sideProjection, y - sideLength/2, (i * 2 + 2) * sideProjection, y );
    }
  }
  line(0, yBottom, sideProjection * NUMBER_ZIGS, yBottom );

}
