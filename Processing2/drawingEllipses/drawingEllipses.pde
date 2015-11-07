float stringLength = 48;
float distanceBetweenFoci = 22;


int gridSize = (int)(800 / stringLength);
float focusDistanceFromCenter = distanceBetweenFoci * 0.5;
float angle0 = -PI/2;
float angle1 = -PI/2;
float xNib, yNib;
float xNibPrevious, yNibPrevious;
ArrayList<Point> nibs = new ArrayList<Point>();
int maxNibs = 1000;

void setup() {
  size(800, 800);
  frameRate(60);
}

void draw() {
  background(0);

  translate(width/2, height/2);

  //drawgrid
  stroke(100);
  strokeWeight(0.5);
  for (int i = 0; i < width /2; i += gridSize) {
    line(i, -height/2, i, height/2);
    line(-i, -height/2, -i, height/2);
  }

  for (int i = 0; i < height /2; i += gridSize) {
    line(-width/2, i, width/2, i);
    line(-width/2, -i, width/2, -i);
  }

  //draw string
  stroke(200);
  strokeWeight(2);
  line(- gridSize * focusDistanceFromCenter, 0
    , gridSize * focusDistanceFromCenter, 0);

  //draw ellipse
  stroke(100);
  strokeWeight(1);
  noFill();
  ellipse(0, 0
    , gridSize * majorAxisLength()
    , gridSize * minorAxisLength());

  //draw path so far, and nib
  float easing = 0.1;
  
  xNib = xNibPrevious * (1-easing) + easing * (mouseX - width / 2);
  yNib  = yNibPrevious * (1-easing) + easing * (mouseY - height / 2);
  xNibPrevious = xNib;
  yNibPrevious = yNib;
  for (int i = 0; i < 20; ++i) {
    moveNibToEllipse();
  }
  
  //add current nib if it has moved more than a pixel, throw out old if too many nibs recorded
  if (nibs.size() == 0) {
    nibs.add(new Point(xNib, yNib));
  } 
  else {
    Point lastNib = nibs.get(nibs.size() - 1);
    if (dist(xNib, yNib, lastNib.x, lastNib.y) > 1.0 / gridSize) {
      nibs.add(new Point(xNib, yNib));
      if (nibs.size() > maxNibs) {
        nibs.remove(0 );
      }
    }
  }

  stroke(255);
  strokeWeight(2);
  for (int i = 1; i < nibs.size(); ++i) {
    Point p0 = nibs.get(i-1);
    Point p1 = nibs.get(i);
    line(gridSize * p0.x, gridSize * p0.y, gridSize * p1.x, gridSize * p1.y);
//    ellipse(gridSize * p0.x, gridSize * p0.y, 1, 1);
  }
  ellipse(gridSize * xNib, gridSize * yNib, 5, 5);
  line(gridSize * xNib, gridSize * yNib, -gridSize * focusDistanceFromCenter, 0);
  line(gridSize * xNib, gridSize * yNib, gridSize * focusDistanceFromCenter, 0);


  //draw foci
  stroke(255, 0, 0);
  strokeWeight(2);
  float focusDiameter = gridSize * 0.1;
  ellipse(- gridSize * focusDistanceFromCenter, 0
    , focusDiameter, focusDiameter);
  ellipse( gridSize * focusDistanceFromCenter, 0
    , focusDiameter, focusDiameter);

}

float moveNibToEllipse() {
  float distToNib = dist(-focusDistanceFromCenter, 0, xNib, yNib) 
    + dist(focusDistanceFromCenter, 0, xNib, yNib);
  float scale = sqrt(majorAxisLength() / distToNib);
  xNib *= scale;
  yNib *= scale;
  return abs(distToNib - 1);
}

float majorAxisLength() {
  return stringLength - 2 * focusDistanceFromCenter;
}
float minorAxisLength() {
  return sqrt(stringLength * stringLength - 4 * stringLength * focusDistanceFromCenter);
}