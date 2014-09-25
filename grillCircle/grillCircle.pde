import processing.pdf.*;
void setup() {
  size(612, 792, PDF, "grillCircle_quarterInch.pdf");//8.5 by 11
  background(255);
  noFill();
  float PIXELS_PER_INCH = 72;
  strokeWeight(PIXELS_PER_INCH * 0.001);

  float diameterInInches = 0.25;
  float diameter = diameterInInches * PIXELS_PER_INCH;
  float xOffset = diameter * 1.5;
  float yOffset = xOffset;
  float distanceBetweenCenters = diameterInInches * 2 * PIXELS_PER_INCH;
  for (int row = 0; row <  11 / diameterInInches; ++row) {
    for (int col = 0; col < 8.5 / diameterInInches; ++col) {
      float x = xOffset + (col + 0.5 * (row % 2))* distanceBetweenCenters;
      float y = yOffset + row * distanceBetweenCenters/2;
      if (x < width - diameter && y < height - diameter) {
        ellipse(x, y, diameter, diameter);
      }
    }
  }
}
