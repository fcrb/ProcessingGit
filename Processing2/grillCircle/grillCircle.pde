import processing.pdf.*;
float PIXELS_PER_INCH = 72;

void setup() {
  size(612, 792, PDF, "grillCircleHex.pdf");//8.5 by 11
  background(255);
  noFill();
  strokeWeight(PIXELS_PER_INCH * 0.001);

  drawTriangles();
}

void drawSquares() {
  float diameterInInches = 0.5;
  float diameter = diameterInInches * PIXELS_PER_INCH;
  float xOffset = diameter * 1.5;
  float yOffset = xOffset;
  float distanceBetweenCenters = diameterInInches * 2 * PIXELS_PER_INCH;
  for (int row = 0; row <  11 / diameterInInches; ++row) {
    for (int col = 0; col < 8.5 / diameterInInches; ++col) {
      float x = xOffset + (col + 0.5 * (row % 2))* distanceBetweenCenters;
      float rowHeightMultiplier = 0.5; //use 0.5 for squares, sqrt(3)/2 for triangles
      float y = yOffset + row * distanceBetweenCenters * rowHeightMultiplier;
      if (x < width - diameter && y < height - diameter) {
        ellipse(x, y, diameter, diameter);
      }
    }
  }
}

void drawTriangles() {
  float diameterInInches = 0.5;
  float diameter = diameterInInches * PIXELS_PER_INCH;
  float xOffset = diameter * 1.5;
  float yOffset = xOffset;
  float separationMultiplier = sqrt(PI / sqrt(3));//equal area inside and outside of circles
  float distanceBetweenCenters = diameterInInches * separationMultiplier * PIXELS_PER_INCH;
  for (int row = 0; row <  11 / diameterInInches; ++row) {
    for (int col = 0; col < 8.5 / diameterInInches; ++col) {
      float x = xOffset + (col + 0.5 * (row % 2))* distanceBetweenCenters;
      float rowHeightMultiplier = sqrt(3)/2; //use 0.5 for squares, sqrt(3)/2 for triangles
      float y = yOffset + row * distanceBetweenCenters * rowHeightMultiplier;
      if (x < width - diameter && y < height - diameter) {
        ellipse(x, y, diameter, diameter);
      }
    }
  }
}
