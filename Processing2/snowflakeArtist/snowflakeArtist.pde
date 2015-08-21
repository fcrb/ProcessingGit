import processing.pdf.*;

String pdfFileName;
float widthInInches;
boolean needsRedraw = false;
boolean includeRing = false;

int SYMMETRY = 6;
int penWidth = 12;
boolean drawingInProgress = false;
boolean printingReviewOn = false;
int imageCounter = 100;
ArrayList<MousePath> mousePaths;

void setup() {
  size(840, 840);
  initializeEdgeCalculator();
  background(255);
  stroke(0);
  strokeWeight(penWidth);
  strokeCap(ROUND);
  fill(0);
  noSmooth();
  mousePaths = new ArrayList<MousePath>();
}

void keyPressed() {
  if (key == 'c') {
    printingReviewOn = false;
    mousePaths = new ArrayList<MousePath>();
    return;
  }   
  if (key == 'u') {
    mousePaths.remove(mousePaths.size() - 1);
    return;
  }   
  String fileName = "snowflake" + ((millis() * 37)%10000);
  if (key == 's') {
    save(fileName+".png" );
    return;
  }   

  if (key == 'p') {
    printingReviewOn = true;
    createEdgeOnlyPDF(fileName+".pdf", 72*12);
    return;
  }   

  if (key == 'r') {
    includeRing = !includeRing;
    return;
  }   

  char[] keyCodes = new char[] {
    '1', '2', '3', '4'
  };
  for (int i = 0; i < keyCodes.length; ++i) {

    if (key == keyCodes[i]) {
      setPenWidth(6*(i+2));
    }
  }

  keyCodes = new char[] {
    '5', '6', '7', '8', '9'
  };
  int[] sym = new int[] {
    5, 6, 8, 12, 16
  };
  for (int i = 0; i < keyCodes.length; ++i) {

    if (key == keyCodes[i]) {
      SYMMETRY = sym[i];
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
  if (printingReviewOn) {
    return;
  }
  background(255);
  stroke(0);
  if (!mousePressed ) {
    drawingInProgress = false;
  } else {
    if (!drawingInProgress) {
      drawingInProgress = true;
      mousePaths.add(new MousePath());
    }
    mousePaths.get(mousePaths.size() - 1).addMousePoint(mouseX  - width/2, mouseY  - height/2);
  }
  translate(width/2, height/2);
  //disallow drawing outside the diameter of drawing area
  //  if (dist(x, y, 0, 0) > width * 0.48) return;
  for (MousePath path : mousePaths) {
    MousePoint previousPoint = path.first();
    for (MousePoint point : path.points) {
      int xOld = previousPoint.x;
      int yOld = previousPoint.y;
      int x = point.x;
      int y = point.y;
      for (int i = 0; i < SYMMETRY; ++i) {
        rotate(2 * PI /  SYMMETRY);
        line(xOld, yOld, x, y);
        line(-xOld, yOld, -x, y);
      }
      previousPoint = point;
    }
  }
  if (includeRing) {
    strokeWeight(width/40);
    stroke(0);
    fill(255);
    ellipse(0, -height * 0.45, width/20, width/20);
    strokeWeight(penWidth);
  }
}
