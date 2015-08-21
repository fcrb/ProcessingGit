ArrayList<Charge> charges;
int linesPerUnitCharge = 6;
float fieldLineLength = 2.5;
float diameterScale = 20;
boolean dragging = true;
void setup() { 
  size(480, 480); 

  charges = new ArrayList<Charge>();
  //  charges.add(new Charge(width/3, height/2, -1));
  //  charges.add(new Charge(2 *  width/3, height/2, +3));
  for (int i = 0; i < 3; ++i) {
    int chg = ((int) (random(5) + 1)) * ((int) (random(1) * 2) * 2 - 1);
    charges.add(new Charge(width * random(1), height * random(1), chg));
  }
} 

void mousePressed() {
  for (Charge  c : charges) {
    if (c.dragIfSelected()) {
      dragging = true;
      return;
    }
  }
}

void mouseReleased() {
  for (Charge  c : charges) {
    c.releaseDrag();
  }
  dragging = false;
  drawFrame();
}

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

  for (Charge chargeToDraw : charges) {
    int numLines = chargeToDraw.charge * linesPerUnitCharge;
    if (numLines < 0) numLines = - numLines;
    for (int lineCtr = 0; lineCtr < numLines; ++lineCtr) {
      boolean atCharge = false;
      float x = chargeToDraw.x + chargeToDraw.diameter * 0.5 * cos(lineCtr * 2 * PI / numLines);
      float y = chargeToDraw.y + chargeToDraw.diameter * 0.5 * sin(lineCtr * 2 * PI / numLines);
      int loopLimit = 1000;
      int loopCtr = 0;
      while (loopCtr++ < loopLimit && !atCharge && x > 0 && x < width && y > 0 && y < height) {
        ForceVector v = new ForceVector(0, 0);
        for (Charge  c : charges) {
          float d = dist(x, y, c.x, c.y);
          //if any charge close to other charges, don't plot
          if (c != chargeToDraw && d < c.diameter * 0.5) atCharge = true;
          //          if ( d < c.diameter) atCharge = true;
          if (!atCharge) {
            float forceMultiplier = c.charge / (d * d);
            v.add( (x - c.x)/d * forceMultiplier, (y - c.y)/d * forceMultiplier);
          }
        }
        if (!atCharge) {
          float vecLength = v.magnitude();
          int directionMult = chargeToDraw.charge > 0 ? 1 : -1;
          float newX = x + directionMult * v.x / vecLength * fieldLineLength;
          float newY = y + directionMult * v.y / vecLength * fieldLineLength;
          //          println("x, y, newX, newY"+  x + y+ newX +  newY);
          float arrowHeadWidthFraction = 5 / fieldLineLength;
          //          strokeWeight(1);
          line(x, y, newX, newY);
          if (loopCtr % 20 == 0) {
            if (chargeToDraw.charge > 0) {
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

  //draw charges
  for (Charge c : charges) {
    c.draw();
  }
} 

void arrowHead(float xFrom, float yFrom, float xTo, float yTo, float headFractionOfLength) {
  float xHeadBase = xTo - (xTo - xFrom) * headFractionOfLength;
  float yHeadBase = yTo - (yTo - yFrom) * headFractionOfLength;
  float xDelta = (yTo - yFrom) * headFractionOfLength * 0.5;
  float yDelta = - (xTo - xFrom) * headFractionOfLength * 0.5;
  triangle(xTo, yTo, xHeadBase + xDelta, yHeadBase + yDelta, xHeadBase - xDelta, yHeadBase - yDelta);
}

class Charge {
  float x, y, diameter;
  int charge;
  boolean drag = false;

  Charge(float x_, float y_, int charge_) {
    x = x_;
    y = y_; 
    charge = charge_; 
    diameter = pow(abs(charge), 1.0/3) * diameterScale;
  }

  boolean dragIfSelected() {
    drag  = (dist(x, y, mouseX, mouseY) < diameter * 0.5);
    return drag;
  }

  void draw() {
    int c = (charge < 0) ? color(0, 0, 255) : color (255, 0, 0);
    noStroke();
    if (drag) {
      x = mouseX;
      y = mouseY;
      fill(255, 255, 0);
      ellipse(x, y, diameter + 5, diameter + 5);
    }
    fill(c);
    ellipse(x, y, diameter, diameter);
    float symbolLength = diameter * 0.6667;
    float symbolThickness = symbolLength * 0.3333;

    //draw charge symbols +/i
    fill(255);
    rect(x - symbolLength / 2, y - symbolThickness / 2, symbolLength, symbolThickness);
    if (charge > 0) {
      rect(x - symbolThickness / 2, y - symbolLength / 2, symbolThickness, symbolLength);
    }
  }

  void releaseDrag() {
    drag = false;
  }
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

