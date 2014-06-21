ArrayList<Mass> masses;
int linesPerUnitMass = 6;
float fieldLineLength = 2.5;
float diameterScale = 20;
boolean dragging = true;
void setup() { 
  size(480, 480); 

  masses = new ArrayList<Mass>();
  for (int i = 0; i < 2; ++i) {
    int m = (int) (random(5)+1);
    masses.add(new Mass(width * random(1), height * random(1), m));
  }
} 

//void mousePressed() {
//  for (Mass  c : masses) {
//    if (c.dragIfSelected()) {
//      dragging = true;
//      return;
//    }
//  }
//}
//
//void mouseReleased() {
//  for (Mass  c : masses) {
//    c.releaseDrag();
//  }
//  dragging = false;
//  drawFrame();
//}

void draw() {
  if (frameCount==1 || dragging) {
    drawFrame();
  }
}

void drawFrame() { 
  background(255);
  smooth();

  //draw field lines
  stroke(200);
  strokeWeight(1.5);

  for (Mass massToDraw : masses) {
    int numLines = massToDraw.mass * linesPerUnitMass;
    if (numLines < 0) numLines = - numLines;
    for (int lineCtr = 0; lineCtr < numLines; ++lineCtr) {
      boolean atMass = false;
      float x = massToDraw.x + massToDraw.diameter * 0.5 * cos(lineCtr * 2 * PI / numLines);
      float y = massToDraw.y + massToDraw.diameter * 0.5 * sin(lineCtr * 2 * PI / numLines);
      int loopLimit = 1000;
      int loopCtr = 0;
      while (loopCtr++ < loopLimit && !atMass && x > 0 && x < width && y > 0 && y < height) {
        ForceVector v = new ForceVector(0, 0);
        for (Mass  c : masses) {
          float d = dist(x, y, c.x, c.y);
          //if any mass close to other mass, don't plot
          if (c != massToDraw && d < c.diameter * 0.5) atMass = true;
          //          if ( d < c.diameter) atMass = true;
          if (!atMass) {
            float forceMultiplier = c.mass / (d * d);
            v.add( (x - c.x)/d * forceMultiplier, (y - c.y)/d * forceMultiplier);
          }
        }
        if (!atMass) {
          float vecLength = v.magnitude();
          float newX = x + v.x / vecLength * fieldLineLength;
          float newY = y + v.y / vecLength * fieldLineLength;
          //          println("x, y, newX, newY"+  x + y+ newX +  newY);
          float arrowHeadWidthFraction = 5 / fieldLineLength;
          //          strokeWeight(1);
          line(x, y, newX, newY);
          if (loopCtr % 20 == 0) {
            if (massToDraw.mass > 0) {
              arrowHead(x, y, newX, newY, arrowHeadWidthFraction);
            } 
            else {
              arrowHead(newX, newY, x, y, arrowHeadWidthFraction);
            }
          }
          x = newX;
          y = newY;
        }
      }
    }
  }

  //draw mass
  for (Mass c : masses) {
    c.draw();
  }
} 

void arrowHead(float xFrom, float yFrom, float xTo, float yTo, float headFractionOfLength) {
  float xHeadBase = xTo + (xTo - xFrom) * headFractionOfLength;
  float yHeadBase = yTo + (yTo - yFrom) * headFractionOfLength;
  float xDelta = (yTo - yFrom) * headFractionOfLength * 0.5;
  float yDelta = - (xTo - xFrom) * headFractionOfLength * 0.5;
  triangle(xTo, yTo, xHeadBase + xDelta, yHeadBase + yDelta, xHeadBase - xDelta, yHeadBase - yDelta);
}

class Mass {
  float x, y, diameter;
  int mass;
//  boolean drag = false;

  Mass(float x_, float y_, int mass_) {
    x = x_;
    y = y_; 
    mass = mass_; 
    diameter = pow(abs(mass), 1.0/3) * diameterScale;
  }

//  boolean dragIfSelected() {
//    drag  = (dist(x, y, mouseX, mouseY) < diameter * 0.5);
//    return drag;
//  }

  void draw() {
    int c =  color (0, 0, 255);
    noStroke();
//    if (drag) {
//      x = mouseX;
//      y = mouseY;
//      fill(255, 255, 0);
//      ellipse(x, y, diameter + 5, diameter + 5);
//    }
    fill(c);
    ellipse(x, y, diameter, diameter);
  }


//  void releaseDrag() {
//    drag = false;
//  }
}

class ForceVector {
  float x, y;

  ForceVector() {
    this(0, 0);
  }

  ForceVector(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void add(float dx, float dy) {
    x += dx;
    y += dy;
  }

  float magnitude() {
    return dist(0, 0, x, y);
  }
}
