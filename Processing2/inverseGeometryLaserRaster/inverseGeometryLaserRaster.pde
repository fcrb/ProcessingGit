import processing.pdf.*;   //<>//

void setup() {
  size(423, 423);//, PDF, "inverseGeometryLaserWeightedTwisted_6in.pdf");

  background(255);
  translate(width/2, height/2);
//  rotate(-PI/12);

  noFill();
  stroke(0);

  int pointsOnSide = 20;
  int borderSize = pointsOnSide / 2 - 4;
  float holeRatio = 0.6;
  float scalar = width *0.74e3/ pointsOnSide;
  drawInverted(rectangularCuttables(pointsOnSide, borderSize, holeRatio), scalar);
//  drawInvertedNonstandard(rectangularCuttables(pointsOnSide, borderSize, holeRatio), scalar);
}

void drawSegments(ArrayList<LineSegment> segments) {
  for (LineSegment segment : segments) {
    segment.draw();
  }
}

void drawInverted(ArrayList<LineSegment> segments, float scalar) {
  for (LineSegment segment : segments) {
    ArrayList<LineSegment> partSegments = segment.inPieces(20 );
    for (LineSegment partSegment : partSegments) {
      partSegment.drawInverted(scalar);
    }
  }
}

void drawInvertedNonstandard(ArrayList<LineSegment> segments, float scalar) {
  for (LineSegment segment : segments) {
    ArrayList<LineSegment> partSegments = segment.inPieces(20 );
    for (LineSegment partSegment : partSegments) {
      partSegment.drawInvertedNonstandard(scalar);
    }
  }
}

ArrayList<LineSegment> rectangularCuttables(int pointsOnSide, int borderSize, float holeRatio) {
  //create rectangular grid that is cuttable
  ArrayList<LineSegment> segments = new ArrayList<LineSegment>();
  float pointSeparation = width / (pointsOnSide + 1.0);
  float squareWidth = pointSeparation * holeRatio;

  //draw inverted grid that is cuttable

  //inner squares
  float upperLeft = - ((pointsOnSide - 1) * pointSeparation  + squareWidth )/ 2  ;
  for (int i = 0; i < pointsOnSide; ++i) {
    float x = upperLeft + pointSeparation * i;
    for (int j = 0; j < pointsOnSide; ++j) {
      float y = upperLeft + pointSeparation * j;
      if (( i < borderSize || pointsOnSide - i <= borderSize) ||
        ( j < borderSize || pointsOnSide - j <= borderSize)) {
        //horizontal lines
        segments.add(new LineSegment(x, y, x + squareWidth, y));
        segments.add(new LineSegment(x, y + squareWidth, x + squareWidth, y + squareWidth));

        //vertical lines
        segments.add(new LineSegment(x, y, x, y+ squareWidth));
        segments.add(new LineSegment(x+ squareWidth, y, x + squareWidth, y+ squareWidth));
      }
    }
  }

  //  //outer border
  upperLeft = - ( (pointsOnSide - borderSize * 2 - 1) * pointSeparation + squareWidth)/2  ;
  int numPieces = 20;
  segments.addAll(new LineSegment(upperLeft, upperLeft, -upperLeft, upperLeft).inPieces(numPieces));
  segments.addAll(new LineSegment(-upperLeft, upperLeft, -upperLeft, -upperLeft).inPieces(numPieces));
  segments.addAll(new LineSegment(-upperLeft, -upperLeft, upperLeft, -upperLeft).inPieces(numPieces));
  segments.addAll(new LineSegment(upperLeft, -upperLeft, upperLeft, upperLeft).inPieces(numPieces));

  return segments;
}
