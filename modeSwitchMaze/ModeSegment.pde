class ModeSegment extends Segment {
  int mode;

  ModeSegment(Vertex v1, Vertex v2, int mode_) {
    super(v1, v2);
    mode = mode_;
  }

  void draw( ) {
    super.draw();
    fill(map(mode, 0, 1, 155, 255));
    float modeSwitchDiameter = segmentLength * 0.2;
    ellipse(v1.xMidpoint(v2), v1.yMidpoint(v2)
      , modeSwitchDiameter, modeSwitchDiameter);
  }

  boolean canAddToPath(Path path) {
    return super.canAddToPath(path) && (path.currentMode() != mode);
  }

  int newMode(int oldMode) {
    return mode;
  }
}
