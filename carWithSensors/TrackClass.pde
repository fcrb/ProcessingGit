int TRACK_COLOR = color(0);
class Track {
  void draw() {
    stroke(TRACK_COLOR);
    strokeWeight(width * 0.05);
    noFill();
    drawThreeOvals();
  }

  void drawThreeOvals() {
    float loopWidth = width * 0.35;
    ellipse(-loopWidth *0.5, 0, loopWidth, height * 0.8);
    ellipse(loopWidth * 0.5, 0, loopWidth, height * 0.8);
    ellipse(0, 0, loopWidth, height * 0.8);
  }
  
  void drawLoopedTrack() {
  }
}
