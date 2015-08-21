import processing.pdf.*;

int numRotations = 4;
float scaleIt = 0.7;
float strokeFractionOfWidth = 0.04;


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
  size(800, 800);
  initializeEdgeCalculator();
  background(255);
  stroke(0);
  strokeWeight(penWidth);
  strokeCap(ROUND);
  fill(0);
  noSmooth();
  mousePaths = new ArrayList<MousePath>();
  maskPixels = shamrockMask(0.15);
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
    '5', '6', '7'
  };
  int[] sym = new int[] {
    2, 4, 8, 
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
  int xCenter = width /3;
  int yCenter = height /3;
  if (!mousePressed ) {
    drawingInProgress = false;
  } else {
    if (!drawingInProgress) {
      drawingInProgress = true;
      mousePaths.add(new MousePath());
    }
    mousePaths.get(mousePaths.size() - 1).addMousePoint(mouseX  - xCenter, mouseY  - yCenter);
  }

  for (int i = 0; i < 4; ++i) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(PI * i / 2);
    translate(-width/2, -height/2);
    translate(xCenter, yCenter);
    //disallow drawing outside the diameter of drawing area
    //  if (dist(x, y, 0, 0) > width * 0.48) return;
    drawMousePath();
    popMatrix();
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

void drawMousePath() {
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
}

int[] shamrockMask(float thickness) {
  float outerWidthMultiple = 0.28;
  float innerWidthMultiple = outerWidthMultiple * (1 - thickness);
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  drawShamrock(pg);
  pg.endDraw();
  pg.loadPixels();
  int[] result = new int[pg.pixels.length];
  arrayCopy(pg.pixels, result);
  return result;
}

void drawShamrock(PGraphics pg) {
  pg.background(255 );
  pg.fill(GREEN);

  pg.translate(width/2, height/2);
  pg.strokeWeight(width * strokeFractionOfWidth);
  pg. noStroke();
  pg.rectMode(CENTER);
  pg. rect(0, 0, height * 0.6, height * 0.6);
  pg.strokeWeight(width * strokeFractionOfWidth);
  pg. stroke(0);

  for (int i = 0; i < numRotations; ++i) {
    pg.pushMatrix();
    pg.scale(1, -1);
    drawShamrockLeaf(pg, scaleIt);
    pg.rotate( -PI/2);
    pg.scale(-1, 1);
    drawShamrockLeaf(pg, scaleIt);
    pg.popMatrix();
    pg.rotate(2 * PI/numRotations);
  }
}

void drawShamrockLeaf(PGraphics pg, float scaleIt) {
  float x1 = 0;//- width * 0.02;
  float y1 = height * 0.25;

  float x2 = x1;
  float y2 = height * 1;

  float x3 = width * 0.5;
  float y3 = height * 0.5;

  float secondAnchorScale = 0.8;
  float x4 = x3 * secondAnchorScale;
  float y4 = y3 * secondAnchorScale;

  pg.bezier(x1 * scaleIt, y1 * scaleIt, x2 * scaleIt, y2 * scaleIt, 
  x3 * scaleIt, y3 * scaleIt, x4 * scaleIt, y4 * scaleIt);
}
