interface DrawSegment {
  // Draw from (0,0) to (sideLengthInPixels, 0);
  void drawSegment();
}

DrawSegment baileySegment = new DrawSegment() {
  void drawSegment() {
    float sixtyDegrees = - PI / 3;
    float stepSize = sideLengthInPixels / 7;
    noFill();
    drawAndTranslateTo(stepSize, 0);    
    rotate(-sixtyDegrees);
    drawAndTranslateTo(stepSize, 0);    
    rotate(sixtyDegrees);
    drawAndTranslateTo(stepSize, 0);    
    rotate(-sixtyDegrees);
    drawAndTranslateTo(stepSize * 2, 0);    
    rotate(sixtyDegrees * 2);
    drawAndTranslateTo(stepSize * 2, 0);    
    rotate(-sixtyDegrees);
    drawAndTranslateTo(stepSize, 0);    
    rotate(sixtyDegrees);
    drawAndTranslateTo(stepSize, 0);    
    rotate(-sixtyDegrees);
    drawAndTranslateTo(stepSize, 0);    
  }
};

void drawAndTranslateTo(float x, float y) {
  line(0,0,x, y);
  translate(x, y);
}

DrawSegment arcSegment = new DrawSegment() {
  void drawSegment() {
    float diameter = sideLengthInPixels * sqrt(3)/3 * 2;
    noFill();
    arc(sideLengthInPixels/2, sideLengthInPixels * sqrt(3)/6, diameter, diameter, 7 * PI/6, 11 * PI/6);
  }
};

DrawSegment sineSegment = new DrawSegment() {
  void drawSegment() {
    int numberSegments = 36;
    beginShape();
    for (int i = 0; i < numberSegments; ++i) {
      float theta = i * PI / numberSegments ;
      vertex( i * sideLengthInPixels / numberSegments, sin(theta) * PPI / PI );
    }
    vertex(sideLengthInPixels, 0);
    endShape();
  }
};



DrawSegment normalSegment = new DrawSegment() {
  //2 sigmas
  void drawSegment() {
    float numSigmas = 3;
    int numberSegments = 50;
    beginShape();
    float z = -numSigmas;
    float zIncrement = 2 * numSigmas / numberSegments;
    for (int i = 0; i < numberSegments; ++i) {
      vertex( (z + numSigmas)/ ( 2 * numSigmas) * sideLengthInPixels
        , (phi(z) - phi(numSigmas)) * phi(0) * sideLengthInPixels);
      z += zIncrement;
    }
    vertex(sideLengthInPixels, 0);
    endShape();
  }

  float phi(float z) {
    return exp(-z * z /2)/sqrt(2 * PI);
  }
};

DrawSegment tSlotSegment = new  DrawSegment() {
  void drawSegment() {
    beginShape();
    vertex(0, 0);
    float slotSide = sideLengthInPixels /8;
    vertex((sideLengthInPixels - slotSide)/2, 0);
    vertex((sideLengthInPixels - slotSide)/2, slotSide);
    vertex((sideLengthInPixels - slotSide)/2 - slotSide, slotSide);
    vertex((sideLengthInPixels - slotSide)/2 - slotSide, 2 * slotSide);
    vertex((sideLengthInPixels + slotSide)/2  + slotSide, 2 * slotSide);
    vertex((sideLengthInPixels + slotSide)/2  + slotSide, slotSide);
    vertex((sideLengthInPixels + slotSide)/2, slotSide);
    vertex((sideLengthInPixels + slotSide)/2, 0);
    vertex(sideLengthInPixels, 0);
    endShape();
  }
};

DrawSegment puzzlePieceSegment = new  DrawSegment() {
  void drawSegment() {
    //    beginShape();
    //    vertex(0, 0);
    //    float radius1 = sideLengthInPixels / ;
    //    float diameter1 = radius1 * 2;
    //    float radius2 = radius1;
    //    float diameter2 = radius2 * 2;
    //    float xCtr = sideLengthInPixels/2 - radius1;
    //    vertex(xCtr, 0);
    //    arc(xCtr, -radius1, diameter1, diameter1, -PI/3, PI/2);
    //    float yCtr = - (radius1 + 
    //    arc(0, -radius1, diameter1, diameter1, -PI/3, PI/2);
    //    endShape();
  }
};

class ZigZagSegment implements DrawSegment {
  float angle;
  ZigZagSegment(float angle_) {
    angle = angle_;
  }
  void drawSegment() {
    beginShape();
    vertex(0, 0);
    vertex(sideLengthInPixels/2, sideLengthInPixels* tan(angle)/2);
    vertex(sideLengthInPixels, 0);
    endShape();
  }
};
