int gridSize = 6;
boolean[][] cellBlack = new boolean[gridSize][gridSize];
int cellWidth;
float TEXT_SIZE;
void setup() { 
  size(320, 320);
  cellBlack[0][0] = true;
  cellBlack[1][1] = false;
  cellWidth = width / ( gridSize + 1);
  TEXT_SIZE = cellWidth * 0.6;
  textSize(TEXT_SIZE);
}

void draw() {
  background(255);

  for (int i = 0; i < gridSize; ++i) {
    for (int j = 0; j < gridSize; ++j) {
      int fillColor = cellBlack[i][j] ? 0 : 255;
      fill(fillColor);
      rect(j * cellWidth, i * cellWidth, cellWidth, cellWidth);
    }
  }
  fill(0);
  for (int i = 0; i < gridSize; ++i) {
    String number = "" + (i+1);
    float w = textWidth(number);
    text(number, i * cellWidth + w, width - TEXT_SIZE/2);
    text(number,  width - (cellWidth + w)/2, (i+ 1.5) * cellWidth - TEXT_SIZE * 1.1);
  }
}

void mouseClicked() {
  int column = (int) (mouseX / cellWidth);
  int row = (int) (mouseY / cellWidth);
  if (column >= gridSize) {
    if (row >= gridSize) return;
    for (int i = 0; i < gridSize; ++i) {
      cellBlack[row][i] = ! cellBlack[row][i];
    }
  } 
  if (row >= gridSize) {
    for (int i = 0; i < gridSize; ++i) {
      cellBlack[i][column] = ! cellBlack[i][column];
    }
  }
}
