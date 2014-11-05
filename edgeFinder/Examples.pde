
void exampleLissajous() {
  pushMatrix();
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 2 * PI / numSteps * i;
    x = width * .45 * cos(15 * angle);
    y = height * .45 * cos(17 * angle);
    if (i > 0) {
      float sw = 8000 / (500 + dist(x, y, 0, 0) / width * 800)* width/400;
      strokeWeight(sw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  popMatrix();
}

void lissajousCircular(float f1, float f2, float sw) {
  background(255);
  pushMatrix();
  translate(width/2, height/2);
  int numSteps = 50000;
  float xPrevious = 0;
  float yPrevious = 0;
  float x, y;
  float insetFraction = 0.9;
  float MAX_RADIUS = dist(0,0,width,height) * insetFraction / 2;
  for (int i = 0; i <= numSteps; ++i) {
    float angle = 8 * PI / numSteps * i;
    x = width * insetFraction/2  * cos (f1 * angle) * cos(f2 * angle);
    y = height * insetFraction/2 * sin (f1 * angle);
    if (i>0) {
      float adjustedSw = sw * MAX_RADIUS / (MAX_RADIUS + dist(0,0,x,y)) ;
      strokeWeight(adjustedSw);
      line(xPrevious, yPrevious, x, y);
    }
    xPrevious = x;
    yPrevious =  y;
  }
  popMatrix();
}

void exampleEllipses() {
  translate(width/2, height/2);
  noFill();
  float strkWeight = width * 0.02;
  float x = width * 0.15;
  float y = 0;
  float w = width * 0.5;
  float h = height * 0.35;
  int n = 12;
  strokeWeight(strkWeight);
  for (int i = 0; i < n; ++i) {
    ellipse(x, y, w, h);
    rotate(2 * PI / n);
  }
}

void drawEllipses(float strkWeight, float distanceToEllipseCenter, 
float ellipseRotation, float ellipseWidth, float h, int n)
{
  translate(width/2, height/2);
  noFill();
  strokeWeight(strkWeight);
  float sizeMultiplier = 0.5;// ((float)0.5) / (ellipseWidth + distanceToEllipseCenter);
  float phi = ellipseRotation * PI /180;
  float x = width * distanceToEllipseCenter * cos(phi) * sizeMultiplier;
  float y = - height * distanceToEllipseCenter * sin(phi * sizeMultiplier);
  for (int i = 0; i < n; ++i) {
    ellipse(x, y, ellipseWidth * width * sizeMultiplier, h * height * sizeMultiplier);
    rotate(2 * PI / n);
  }
}

void exampleFractalTree(float angleScale, float angleShift) {
  drawTree(width * 0.5f, height * 0.95f, width * 0.5f, height * 0.83f, 0, angleScale, angleShift);
}

private void drawTree(float x1, float y1, float x2, float y2, int level, float angleScale, float angleShift) {
  int maxLevel = 8;
  if (level > maxLevel) {
    return;
  }
  float rotation = PI * 0.125;
  float scaleDown = 0.85f;
  // draw the trunk of the tree
  //  stroke(level * level * 255.0f / maxLevel / maxLevel, 0, 0);
  stroke(0);
  float strokeWt = (maxLevel - level + 5) * width / 800;
  strokeWeight(strokeWt);
  line(x1, y1, x2, y2);

  // create two branches, each of which is another tree (recursion!)
  float angle = (rotation + angleShift) * angleScale;
  float cosR = cos(angle);
  float sinR = sin(angle);
  drawTree(x2, y2, 
  x2 + scaleDown * (cosR * (x2 - x1) - sinR * (y2 - y1)), y2
    + scaleDown * (sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1, angleScale, angleShift);
  angle = (rotation - angleShift) * angleScale;
  cosR = cos(angle);
  sinR = sin(angle);
  drawTree(x2, y2, 
  x2 + scaleDown * (cosR * (x2 - x1) + sinR * (y2 - y1)), y2
    + scaleDown * (-sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1, angleScale, angleShift);
}

void exampleStarOfDavid() {
  background(255);
  translate(width/2, height/2);
  float heightAboveCenter = width * 0.3;
  strokeWeight(heightAboveCenter * 0.2);
  noFill();
  float xRight = heightAboveCenter * sqrt(3)/2;
  float yTop = - heightAboveCenter;
  float yBottom = heightAboveCenter * 0.5;
  for (int i = 0; i < 2; ++i) {
    triangle(-xRight, yBottom, xRight, yBottom, 0, yTop);
    rotate(PI);
  }
  fill(255);
  strokeWeight(1);
  float holeDiameter = heightAboveCenter * 0.1;
  ellipse(0, yTop * 0.95, holeDiameter, holeDiameter);
}

void exampleMobileSpar() {
  background(255);
  noFill();
  translate(width/2, height/2);
  int numCircles = 30;
  float maxRadius = width / 8;
  float curvatureScalar = 0.12;
  float curveScalar = 3;
  float strokeWtScale = 0.35;
  float separationScale = 1;
  float x = -width/2 * 0.9;
  float y = 0;

  for (int i = 1; i <= numCircles; ++i ) {
    float radius = abs(maxRadius * sin((i + 5) * 0.01));
    float dx = radius * separationScale;
    x += dx ;
    y -= curveScalar * curvatureScalar * sin(i * curvatureScalar) * dx ;
    strokeWeight(radius * strokeWtScale);
    ellipse(x, y, 2 * radius, 2 * radius);
  }
}

void exampleFromFile( String fileName) {
  PImage img;
  img = loadImage(fileName);
  image(img, 0, 0);
}

void exampleRegularPolygonFractal() {
  background(255);
  translate(width/2, height/2);
  int numVertices = 6;
  if (numVertices % 2 == 1)
    rotate(-PI/2);
  else
    rotate(PI/numVertices);
  float initialRadius = width *0.3;
  //noFill();
  drawRegularPolygonFractal(0, 0, initialRadius, 0, numVertices);
}

void drawRegularPolygonFractal(float x, float y, float radius, int level, int numVertices) {
  float scaleDown = 0.37;
  int maxLevel = 5;
  if (level > maxLevel) {
    return;
  }
  if (level > 1) 
    fill(0); 
  else fill(255);
  polygon(x, y, radius, numVertices);
  float newRadius = radius  * scaleDown;
  for (int i = 0; i < numVertices; ++i) {
    float angle = i * 2 * PI / numVertices;
    drawRegularPolygonFractal(x + radius * cos(angle), 
    y - radius * sin(angle), 
    newRadius, 
    level + 1, numVertices);
  }
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
