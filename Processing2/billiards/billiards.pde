float xCells = 3;
float yCells = 2;
float insetFraction = 0.1;
float cellWidth, xLeft, xRight, yTop, yBottom;
Ball ball;
ArrayList<Point> trace;
int MAX_POINTS = 10000;
float speed = 3.0001;

interface JavaScript {
  void showValues(float h, float w);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(640, 320);
  frameRate(120);
  initialize();
}

void setHeight(float h) {
  yCells = h;
  initialize();
}

void setWidth(float w) {
  xCells = w;
  initialize();
}

void initialize() {
  cellWidth = min(width / xCells, height/yCells) * (1 - insetFraction * 2);
  xLeft = 0.5 * ( width - (cellWidth * xCells));
  xRight = xLeft + cellWidth * xCells;
  yTop = 0.5 * ( height - (cellWidth * yCells));
  yBottom = yTop + cellWidth * yCells;
  ball = new Ball();
  trace = new ArrayList<Point>();
}


void draw() {
  if (ball.stopped) return;
  if (javascript!=null)
    javascript.showValues(xCells, yCells);
  background(0);
  fill(255);
  rect(xLeft, yTop, xRight - xLeft, yBottom - yTop);

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
  stroke(255, 0, 0);
  strokeWeight(1);
  Point previousPoint = new Point(xLeft, yBottom);
  for (Point point: trace) {
    //point.draw();
    line(previousPoint.x, previousPoint.y, point.x, point.y);
    previousPoint = point;
  }

  ball.draw();

  //add ball's location to trace
  while (trace.size () >= MAX_POINTS) {
    trace.remove(0);
  }
  trace.add(new Point(ball.x, ball.y));
}

