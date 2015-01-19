import processing.pdf.*;

float widthInInches;
boolean needsRedraw = false;
boolean includeRing = false;

int SYMMETRY = 6;
int penWidth = 12;
boolean drawingInProgress = false;
boolean printingReviewOn = false;
int imageCounter = 100;
ArrayList<MousePath> mousePaths;
int[] maskPixels;
int GREEN = color(0, 255, 0);


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
  maskPixels = heartMask(0.15);
}

void keyPressed() {
  if (key == 'c') {
    printingReviewOn = false;
    mousePaths = new ArrayList<MousePath>();
    return;
  }   
  if (key == 'u' ) {
    if (printingReviewOn) {
      printingReviewOn = false;
    } else {
      if ( mousePaths.size() > 0) {
        mousePaths.remove(mousePaths.size() - 1);
      }
    }
    return;
  }   
  String fileName = "heart" + ((millis() * 37)%10000);
  if (key == 's') {
    //    save(fileName+".png" );
    for (MousePath path : mousePaths) {
      path.smoothPath();
    }
    return;
  }   

  if (key == 'p') {
    printingReviewOn = !printingReviewOn;
    if (printingReviewOn) {
      createEdgeOnlyPDF(fileName+".pdf", 72*12);
    }
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
      setPenWidth(3*(i+2));
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
      float xOld = previousPoint.x;
      float yOld = previousPoint.y;
      float x = point.x;
      float y = point.y;
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

  //mask
  loadPixels();
  for (int row = 0; row < height; ++row) {
    for (int col = 0; col < width; ++col) {
      int pixIndex = col + row * width;
      int maskPixel = maskPixels[pixIndex];
      if (maskPixel == WHITE) {
        pixels[pixIndex] = WHITE;
      } else if (maskPixel == BLACK) {
        pixels[pixIndex] = BLACK;
      }
    }
  }
  updatePixels();
}

int[] heartMask(float thickness) {
  float outerWidthMultiple = 0.28;
  float innerWidthMultiple = outerWidthMultiple * (1 - thickness);
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.noSmooth();
  pg.rectMode(CENTER);
  pg.background(255);
  pg.stroke(BLACK);
  pg.fill(BLACK);
  float radius = width * outerWidthMultiple;
  float diameter = radius * 2;  
  pg.translate(width / 2, height * 0.55);
  pg.strokeWeight(2);
  float xCenter = -radius / sqrt(2);
  pg.arc(xCenter, xCenter, diameter, diameter, 3 * PI /4, 7 * PI / 4);
  pg.arc(-xCenter, xCenter, diameter, diameter, 5 * PI /4, 9 * PI / 4);
  pg.rotate(PI/4);
  pg.rect(0, 0, diameter, diameter);
  pg.rotate(-PI/4);
  pg.stroke(GREEN);
  pg.fill(GREEN);
  radius = width * innerWidthMultiple;
  diameter = radius * 2;  
  pg.arc(xCenter, xCenter, diameter, diameter, 3 * PI /4, 7 * PI / 4);
  pg.arc(-xCenter, xCenter, diameter, diameter, 5 * PI /4, 9 * PI / 4);
  pg.rotate(PI/4);
  float delta = width * (outerWidthMultiple - innerWidthMultiple);
  pg.rect(-delta/2, 0, diameter + delta, diameter);
  pg.rotate(-PI/2);
  pg.rect(delta/2, 0, diameter + delta, diameter);
  pg.endDraw();
  pg.loadPixels();
  int[] result = new int[pg.pixels.length];
  arrayCopy(pg.pixels, result);
  return result;
}
