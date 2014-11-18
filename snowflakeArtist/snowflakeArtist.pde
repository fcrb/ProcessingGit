import processing.pdf.*;

String pdfFileName;
float widthInInches;
boolean needsRedraw = false;

int SYMMETRY = 6;
int penWidth = 5;
float xOld, yOld;
boolean drawingInProgress = false;
int imageCounter = 100;

void setup() {
  size(800, 800);
  initializeEdgeCalculator();
  background(255);
  stroke(0);
  strokeWeight(penWidth);
  strokeCap(ROUND);
  fill(0);
  background(255);
  noSmooth();
}

void keyPressed() {
  if (key == 'c') {
    background(255);
    return;
  }   
  if (key == 's') {
    save("snowflake"+(imageCounter++)+".png" );
    return;
  }   

  if (key == 'p') {
    createEdgeOnlyPDF("snowflake"+(imageCounter++)+".pdf", 72*12);
    return;
  }   

  char[] keyCodes = new char[] {
    '1', '2', '3', '4', '5', '6', '7', '8', '9'
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
