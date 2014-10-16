/*
Example usage:
  pushMatrix();
  translate(width/2, height/2);
  drawGrid(-width/2, -height/2, 20, 100, 12);
  drawMouseCoordinates(-width/2, -height/2, 9);
  popMatrix();
*/
 
void drawGrid(int xStart, int yStart, int minorIncrement, int majorIncrement, float textHeight) {
  //minor grid
  drawGridLines(xStart, yStart, minorIncrement, 245);
  //major grid
  drawGridLines(xStart, yStart, majorIncrement, 220);
  drawGridLabels(xStart, yStart, majorIncrement, textHeight);
}
 
void drawGridLines(int xStart, int yStart, int gridInterval, int color_) {
  stroke(color_);
  strokeWeight(1);
  fill(0);
 
  xStart -= xStart % gridInterval;
  yStart -= yStart % gridInterval;
 
  //draw vertical lines
  for (int i = 0; i < width; i += gridInterval) {
    int x = xStart + i;
    line(x, -1000000, x, 1000000);
  }
  //draw horizontal lines
  for (int j = 0; j < height; j += gridInterval) {
    line(-1000000, yStart + j, 1000000, yStart + j);
  }
}
 
void drawGridLabels(int xStart, int yStart, int gridInterval, float textHeight) {
  textSize(textHeight);
  fill(150);
  xStart -= xStart % gridInterval;
  yStart -= yStart % gridInterval;
 
 
  //draw x-axis labels
  for (int i = 0; i < width; i += gridInterval) {
    int x = xStart + i;
    String xAxisLabel = ""+x;
    text(xAxisLabel, x - textWidth(xAxisLabel)/2, textHeight/2);
  }
 
  //draw y-axis labels
  for (int j = 0; j < height; j += gridInterval) {
    int y = yStart + j;
    String yAxisLabel = ""+y;
    text(yAxisLabel, - textWidth(yAxisLabel)/2, y + textHeight/2);
  }
}
 
void drawMouseCoordinates(float xLeft, float yTop, float textHeight) {
  fill(127);
  String label = "("+(mouseX + xLeft) + ","+(mouseY+ yTop)+")";
  textSize(textHeight);
  text(label, xLeft + 5, yTop + textHeight);
}
