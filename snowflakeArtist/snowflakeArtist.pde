int SYMMETRY = 6;
int penWidth = 5;
float xOld, yOld;
boolean drawingInProgress = false;

interface JavaScript {
  void showValues(int penWidth);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(800, 800);
  background(255);
  stroke(0);
  strokeWeight(penWidth);
  strokeCap(ROUND);
  fill(0);
}

void keyPressed() {
  char[] keyCodes = new char[] {
    '1', '2', '3', '4', '5', '6','7','8','9'
  };
  for (int i = 0; i < keyCodes.length; ++i) {

    if (key == keyCodes[i]) {
      setPenWidth(5*(i+3));
    }
  }
}

void setPenWidth(int w) {
  penWidth = w;
  strokeWeight(penWidth);
}

void eraseDrawing() {
  background(255);
}

void draw() {
  if (javascript!=null) 
    javascript.showValues(penWidth);
  if (!mousePressed ) {
    drawingInProgress = false;
    return;
  } 
  translate(width/2, height/2);
  float x = mouseX  - width/2;
  float y = mouseY  - height/2;
  if (!drawingInProgress) {
    xOld = x;
    yOld = y;
    drawingInProgress = true;
  }
  //disallow drawing outside the diameter of drawing area
  if (dist(x, y, 0, 0) > width * 0.48) return;
  for (int i = 0; i < SYMMETRY; ++i) {
    rotate(2 * PI /  SYMMETRY);
    line(xOld, yOld, x, y);
    line(-xOld, yOld, -x, y);
  }
  xOld = x;
  yOld = y;
}
