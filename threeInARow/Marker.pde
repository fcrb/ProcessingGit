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
