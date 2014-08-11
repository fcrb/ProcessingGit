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
  text(message, (width - textWidth(message))*0.5, height - inset * 5/4);
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
  println("mousePressed fc="+frameCount);
  if (gameOver() || !player().donePlacingMarkers()) {
    return;
  }
  player().dragIfSelected();
}  

void mouseReleased() {
  println("mouseReleased fc="+frameCount);
  if (gameOver() || !player().donePlacingMarkers()) {
    return;
  }
  player().releaseDrag();
}  

void mouseClicked() {
  println("mouseClicked fc="+frameCount);
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
