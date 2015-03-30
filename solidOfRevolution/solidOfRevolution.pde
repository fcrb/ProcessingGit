import processing.opengl.*;

int numberCylinderSides= 60;
float zLevel = 0;
float xMin = -250;
float xMax = 251;
float dx = 10;
boolean drawWashers = false;
boolean drawEnds = true;
int fillColor = color(255, 150, 0, 255);

void setup()
{
  size(800, 800, P3D);
}

float f(float x) {
  return sin(0.006 * x) * 200;
}

float f2(float x) {
  return f(x)* 0.9;
}

void draw()
{
  if (keyPressed && key == CODED) {
    if ( keyCode == UP) {
      ++zLevel;
    } else if (keyCode == DOWN) {
      --zLevel;
    }
  }

  background(0);
  lights();
  translate( width/2, height/2, zLevel * 2 );
  rotateY( PI /2 + (mouseX - width/2) * 0.01);

  //axes
//  fill (255, 255, 0);
//  drawCylinderSides(numberCylinderSides, width * 0.01, 0, width * 0.45);

  //solids of revolution
  noStroke();
  fill(fillColor);
  for (float x = xMin; x < xMax; x += dx) {
    if (drawWashers) {
      drawWasher( numberCylinderSides, x, f(x), f2(x), dx);
    } else {
      drawDisc( numberCylinderSides, x, f(x), dx);
    }
  }
}

void drawDisc( int sides, float xLeftSide, float radius, float thickness)
{
  // draw top of the tube
  if (drawEnds) {  
    drawEndOfCylinder(sides, radius, xLeftSide);
    drawEndOfCylinder(sides, radius, xLeftSide + thickness);
  }

  drawCylinderSides(sides, radius, xLeftSide, thickness);
}

void drawEndOfCylinder(int sides, float radius, float distance) {
  beginShape();
  for (int i = 0; i < sides; i++) {
    float angle =  i * 2 * PI/ sides;
    vertex( cos(angle) * radius, sin(angle) * radius, distance);
  }
  endShape(CLOSE);
}

void drawWasher( int sides, float xLeftSide, float rOuter, float rInner, float thickness)
{
  if (drawEnds) {  
    drawFlatSurfaceOfWasher(sides, rOuter, rInner, xLeftSide);
    drawFlatSurfaceOfWasher(sides, rOuter, rInner, xLeftSide + thickness);
  }
  drawCylinderSides(sides, rOuter, xLeftSide, thickness);
  drawCylinderSides(sides, rInner, xLeftSide, thickness);
}


void drawFlatSurfaceOfWasher(int sides, float rOuter, float rInner, float distance) {
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float angle =  i * 2 * PI/ sides;
    float x = cos( angle ) ;
    float y = sin( angle);
    vertex( x * rOuter, y * rOuter, distance);
    vertex( x * rInner, y * rInner, distance);
  }
  endShape(CLOSE);
}

void drawCylinderSides(int sides, float radius, float distance, float thickness) {
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float angle =  i * 2 * PI/ sides;
    float x = cos( angle) * radius;
    float y = sin(angle ) * radius;
    vertex( x, y, distance);
    vertex( x, y, distance+thickness);
  }
  endShape(CLOSE);
}
