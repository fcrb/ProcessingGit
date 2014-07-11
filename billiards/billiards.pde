float xCells = 3.2;
float yCells = 2.5;
float insetFraction = 0.1;
float cellWidth, xLeft, xRight, yTop, yBottom;
Ball ball;

void setup() {
  size(640, 320);
  cellWidth = min(width / xCells, height/yCells) * (1 - insetFraction * 2);
  xLeft = 0.5 * ( width - (cellWidth * xCells));
  xRight = xLeft + cellWidth * xCells;
  yTop = 0.5 * ( height - (cellWidth * yCells));
  yBottom = yTop + cellWidth * yCells;
  ball = new Ball();
}

void draw() {
  background(255);

  //draw table 
  stroke(192); 
  //vertical lines
  for (int i = 0; i < xCells; ++i) {
    float x = xLeft + i * cellWidth;
    line(x, yTop, x, yBottom);
  }
  line(xRight, yTop, xRight, yBottom);

  //horizontal lines. Draw bottom up to accomodate possible
  //fractional height
  for (int i = 0; i < yCells; ++i) {
    float y = yBottom - i * cellWidth;
    line(xLeft, y, xRight, y);
  }
  line(xLeft, yTop, xRight, yTop);

  //draw ball
  ball.draw();
}
