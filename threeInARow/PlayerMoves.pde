class PlayerMoves {
  int fillColor;
  String name;
  boolean[][] occupiesCell = new boolean[gridSize][gridSize];
  ArrayList<Marker> markers = new ArrayList<Marker>();
  PlayerMoves otherPlayer;
  int[][] magicSquareValues = {
    {
      8, 1, 6
    }
    , {
      3, 5, 7
    }
    , {
      4, 9, 2
    }
  };

  PlayerMoves(String name_, int fillColor_) {
    name = name_;
    fillColor = fillColor_;
  }

  boolean canAddCell(int i, int j) {
    return !donePlacingMarkers() && !occupiesCell[i][j] && !otherPlayer.occupiesCell[i][j];
  }

  boolean canMoveTo(int i, int j) {
    return !occupiesCell[i][j];
  }

  boolean addCell(int i, int j) {
    markers.add(new Marker(i, j, this));
    return occupiesCell[i][j] = true;
  }

  boolean donePlacingMarkers() {
    return markers.size() == gridSize;
  }

  void dragIfSelected() {
//    if (!donePlacingMarkers()) return;
    for (Marker marker : markers ) {
      marker.dragIfSelected();
    }
  }

  void releaseDrag() {
    for (Marker marker : markers ) {
      marker.releaseDrag();
    }
  }


  boolean inCell(int i, int j) {
    return occupiesCell[i][j];
  }

  boolean hasWon() {
    int sum = 0;
    for (int i = 0; i < gridSize; ++i) {
      for (int j = 0; j < gridSize; ++j) {
        if (inCell(i, j)) {
          sum +=magicSquareValues[i][j];
        }
      }
    }
    return sum == 15;
  }

  String instruction() {
    if (markers.size() < gridSize) {
      return name + "'s turn to place marker.";
    }
    if (hasWon()) {
      return name + " wins.";
    }
    return name + "'s turn to drag a marker.";
  }

  void draw() {
    for (Marker marker : markers ) {
      marker.draw();
    }
  }

  void setOtherPlayer(PlayerMoves other) {
    otherPlayer = other;
  }
}
