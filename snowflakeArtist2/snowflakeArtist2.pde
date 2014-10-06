int SYMMETRY = 6;
int penWidth = 5;
float MAX_RADIUS;
float xStart, yStart, xFinish, yFinish;
ArrayList<Stroke> strokes;
boolean drawingInProgress = false;
boolean readyToDraw = false;

//interface JavaScript {
//  void showValues(int penWidth);
//}
//
//void bindJavascript(JavaScript js) {
//  javascript = js;
//}
//
//JavaScript javascript;

void setup() {
  size(600, 600);

  strokes = new ArrayList<Stroke>();
  MAX_RADIUS = width * 0.48;
}

void keyPressed() {
  char[] penWidthCodes = new char[] {
    '1', '2', '3', '4', '5', '6', '7', '8', '9'
  };
  for (int i = 0; i < 9; ++i) {

    if (key == penWidthCodes[i]) {
      setPenWidth(width*(i+1)/ 100);
    }
  }

  if (key == 'z' && strokes.size() > 0) {
    strokes.remove(strokes.size() - 1 );
  }
}

void mouseClicked() {
  drawingInProgress = !drawingInProgress;
  if (drawingInProgress) {
    xStart = mouseX - width/2;
    yStart = mouseY - height/2;
  } 
  else {
    strokes.add(new Stroke(xStart, yStart, mouseX - width/2, mouseY - height/2, penWidth));
  }
}


void setPenWidth(int w) {
  penWidth = w;
}

void eraseDrawing() {
  strokes = new ArrayList<Stroke>();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  strokeWeight(1);

  stroke(200);
  noFill();
  ellipse(0, 0, MAX_RADIUS * 2, MAX_RADIUS * 2);
  for (int i = 0; i < SYMMETRY ; ++i) { 
    line(-MAX_RADIUS, 0, MAX_RADIUS, 0);
    rotate(PI/6);
  }

  noStroke();
//  if (javascript!=null) 
//    javascript.showValues(penWidth);

  fill(0);
  for (Stroke stroke_: strokes) {
    stroke_.drawSymmetrically();
  }

  if (drawingInProgress) {
    float xNew = mouseX - width/2;
    float yNew = mouseY - height/2;
    float radius = dist(0,0,xNew, yNew);
    if(radius > MAX_RADIUS) {
      xNew *= MAX_RADIUS / radius;
      yNew *= MAX_RADIUS / radius;
    }
    Stroke newStroke = new Stroke(xStart, yStart, xNew, yNew, penWidth);
    fill(color(0, 0, 255));

    newStroke.drawSymmetrically( );
  }
}

void hexLine(float x0, float y0, float x1, float y1, float lineWidth) {
  pushMatrix();
  float endCapEdgeLength = lineWidth / sqrt(3);
  Vec2D v = new Vec2D(x1 - x0, y1-y0);
  beginShape();
  translate(x0, y0);
  vertex(0, 0);
  Vec2D vScaledToEndCapEdge = v.scaleToLength(endCapEdgeLength);
  Vec2D w = vScaledToEndCapEdge.rotateRadians(PI/3);
  vertex(w.x, w.y);
  w = v.plus(vScaledToEndCapEdge.rotateRadians(2 * PI/3)); 
  vertex(w.x, w.y);
  w = v;
  vertex(w.x, w.y);
  w = v.minus(vScaledToEndCapEdge.rotateRadians(PI/3)); 
  vertex(w.x, w.y);
  w = vScaledToEndCapEdge.rotateRadians(- PI/3);
  vertex(w.x, w.y);
  endShape(CLOSE);
  popMatrix();
}

