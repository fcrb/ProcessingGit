int gridSize = 3;
boolean whitesTurn = true;
float sw = 2;//strokeWeight
float inset = sw * 12;
float gridSpacing;
PlayerMoves whiteMoves, blackMoves;

void setup() {
  size(320, 320);
  gridSpacing = (width - inset * 2) / gridSize;
  whiteMoves = new PlayerMoves("White", 255);
  blackMoves = new PlayerMoves("Black", 0);
  whiteMoves.setOtherPlayer(blackMoves);
  blackMoves.setOtherPlayer(whiteMoves);
}

void draw() {
  background(255);
  strokeWeight(sw );
  stroke(220);
  pushMatrix();
  translate(inset, inset);
  //draw grid 
  for (int i = 0; i <= gridSize; ++i) {
    //horizontal gridline
    line(0, i * gridSpacing, gridSize * gridSpacing, i * gridSpacing);
    //vertical gridline
    line(i * gridSpacing, 0, i * gridSpacing, gridSize * gridSpacing);
  }

  //draw text to indicate whose turn it is
  stroke(0);
  String message = player().instruction();
  if (otherPlayer().hasWon() ) {
    message = otherPlayer().instruction();
  }
  textSize(inset * 0.5);
  fill(0);
  //TODO The textWidth snippet should center the message. Buggy.
  text(message, (width - textWidth(message))*0.5 - inset, height - inset * 5/4);
  popMatrix();

  //draw  markers
  whiteMoves.draw();
  blackMoves.draw();
}

PlayerMoves player() {
  return whitesTurn ? whiteMoves : blackMoves;
}

PlayerMoves otherPlayer() {
  return player().otherPlayer;
}

boolean gameOver() {
  return player().hasWon() || otherPlayer().hasWon();
}

void mousePressed() {
  if (gameOver() || !player().donePlacingMarkers()) {
    return;
  }
  player().dragIfSelected();
}  

void mouseReleased() {
  if (gameOver() || !player().donePlacingMarkers()) {
    return;
  }
  player().releaseDrag();
}  

void mouseClicked() {
  if (gameOver()) { 
    return;
  }
  int mouseI = (int) ((mouseX - inset)/gridSpacing);
  int mouseJ = (int) ((mouseY - inset)/gridSpacing);
  if (mouseI < 0 || mouseI >= gridSize || mouseJ < 0 || mouseJ >= gridSize)
    return;
  if (player().canAddCell(mouseI, mouseJ)) {
    player().addCell(mouseI, mouseJ);
    whitesTurn = !whitesTurn;
  }
}
class Marker {
  float x, y;
  int i, j;
  float diameter = gridSpacing *0.6;
  PlayerMoves player;
  boolean drag = false;

  Marker(int i_, int j_, PlayerMoves player_) {
    i = i_;
    j = j_; 
    player = player_;
    centerInCell();
  }

  void dragIfSelected() {
    if (player.donePlacingMarkers())
      drag  = (dist(x, y, mouseX, mouseY) < diameter * 0.5);
    else drag = false;
  }

  void draw() {
    if (drag) {
      x = mouseX;
      y = mouseY;
      //draw valid choices
      for (int i_ = 0; i_ < gridSize; ++i_) {
        for (int j_ = 0; j_ < gridSize; ++j_) {
          if (validMove(i_, j_)) {
            int gray = (int) map(sin(millis()*0.005), -1, 1, 220, 250);
            noStroke();
            fill(gray);
            ellipse(center(i_), center(j_), diameter, diameter);
          }
        }
      }
    } 
    else {
      centerInCell();
    }
    stroke(0);
    fill(player.fillColor);
    ellipse(x, y, diameter, diameter);
  }

  void releaseDrag() {
    if (!drag) { 
      return;
    }
    drag = false;
    int newI = (int)((mouseX - inset)/gridSpacing);
    int newJ = (int)((mouseY - inset)/gridSpacing);
    if (validMove(newI, newJ)) {
      player.occupiesCell[i][j] = false;
      i = newI; 
      j = newJ;
      player.occupiesCell[i][j] = true;
      centerInCell();
      whitesTurn = !whitesTurn;
    }
  }

  boolean validMove(int newI, int newJ) {
    if (player.occupiesCell[newI][newJ]) return false;
    if (otherPlayer().occupiesCell[newI][newJ]) return false;
    return (abs(newI - i) + abs(newJ - j)) == 1;
  }


  void centerInCell() {
    x= center(i); 
    y =center(j);
  }

  float center(int i) {
    return (i + 0.5) * gridSpacing + inset;
  }
}
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

