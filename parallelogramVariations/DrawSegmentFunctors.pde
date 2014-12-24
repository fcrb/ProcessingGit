interface DrawSegment {
  // Draw from (0,0) to (sideLengthInPixels, 0);
  void drawSegment();
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
    int numberSegments = 24;
    beginShape();
    for (int i = 0; i < numberSegments; ++i) {
      float theta = i * PI / numberSegments ;
      vertex( i * sideLengthInPixels / numberSegments, sin(theta) * PPI / PI / 2);
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

class ZigZagSegment implements DrawSegment {
  float angle;
  ZigZagSegment(float angle_) {
    angle = angle_;
  }
  void drawSegment() {
    beginShape();
    vertex(0, 0);
    vertex(sideLengthInPixels/2, sideLengthInPixels* tan(angle)/2);
    //    vertex(sideLengthInPixels/2, 0);
    vertex(sideLengthInPixels, 0);
    endShape();
  }
};
