float xCells = 7;
float yCells = 5;
float insetFraction = 0.1;
float cellWidth, xLeft, xRight, yTop, yBottom;
Ball ball;
ArrayList<Point> trace;
int numPoints = 1000;
float speed = 3;

void setup() {
  size(640, 320);
  cellWidth = min(width / xCells, height/yCells) * (1 - insetFraction * 2);
  xLeft = 0.5 * ( width - (cellWidth * xCells));
  xRight = xLeft + cellWidth * xCells;
  yTop = 0.5 * ( height - (cellWidth * yCells));
  yBottom = yTop + cellWidth * yCells;
  ball = new Ball();
  trace = new ArrayList<Point>();
  frameRate(120);
}

void draw() {
  if(ball.stopped) return;
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
  for (Point point: trace) {
    point.draw();
  }

  ball.draw();

  //add ball's location to trace
  while (trace.size () >= numPoints) {
    trace.remove(0);
  }
  trace.add(new Point(ball.x, ball.y));
}

