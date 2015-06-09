int TRACK_COLOR = color(0);
class Track {
  void draw() {
    stroke(TRACK_COLOR);
    strokeWeight(width * 0.05);
    noFill();
    ellipse(0, 0, width * 0.2, height * 0.8);
    ellipse(0, 0, width * 0.4, height * 0.6);
    ellipse(0, 0, width * 0.6, height * 0.4);
  }
}
