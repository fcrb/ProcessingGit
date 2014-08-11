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
    stroke(0);
    fill(player.fillColor);
    if (drag) {
      x = mouseX;
      y = mouseY;
    } 
    else {
      centerInCell();
    }
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
    x= (i + 0.5) * gridSpacing + inset; 
    y =(j + 0.5) * gridSpacing + inset;
  }
}
