class PlayerMoves {
  int fillColor;
  String name;
  boolean[][] occupiesCell = new boolean[gridSize][gridSize];
  int numberOfMarkersPlaced = 0;
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

  boolean canMoveTo(int i, int j) {
    return !occupiesCell[i][j];
  }

  boolean addCell(int i, int j) {
    ++numberOfMarkersPlaced;
    return occupiesCell[i][j] = true;
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
    if (numberOfMarkersPlaced < gridSize) {
      return name + "'s turn to place marker.";
    }
    if (hasWon()) {
      return name + " wins.";
    }
    return name + "'s turn to drag a marker.";
  }
//
//  void dragIfSelected() {
//    drag  = (dist(x, y, mouseX, mouseY) < diameter * 0.5);
//  }


  void draw() {
    stroke(0);
    fill(fillColor);
    float dia = gridSpacing *0.6;
    for (int i = 0; i < gridSize; ++i) {
      for (int j = 0; j < gridSize; ++j) {
        if (inCell(i, j)) {
          ellipse( (i + 0.5) * gridSpacing, (j + 0.5) * gridSpacing, dia, dia);
        }
      }
    }
  }
}
