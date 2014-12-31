int mazeRowCount = 10;
ArrayList<Cell> cellsToBuildUpon;
//ArrayList<Cell> completedCells;
boolean[][] cellIsAvailable;
Cell startCell, finishCell;
Cell[] neighbors;
ArrayList<Link> links;

void setup() {
  size(600, 600);
  cellsToBuildUpon = new ArrayList<Cell>();
  links = new ArrayList<Link>();
  neighbors = new Cell[] { 
    new Cell(-1, 0), new Cell(1, 0), new Cell(0, -1), new Cell(0, 1)
    };

    newRectangularGrid();

  background(0); 
  //  rectMode(CENTER);
  float cellWidth = width / (mazeRowCount + 1);
  scale(cellWidth, -cellWidth);
  translate(1, - mazeRowCount);
  strokeWeight(0.5);
  stroke(255);
  strokeCap(PROJECT);
  drawMaze();

  //mark start and end with green and red dot
  noStroke();
  fill(0, 255, 0);
  float dotSize = 0.3;
  ellipse(startCell.x, startCell.y, dotSize, dotSize);
  fill(255, 0, 0);
  ellipse(finishCell.x, finishCell.y, dotSize, dotSize);
}

void newRectangularGrid() {
  cellIsAvailable = new boolean[mazeRowCount][mazeRowCount];
  for (int i = 0; i < mazeRowCount; ++i) {
    for (int j = 0; j < mazeRowCount; ++j) {
      cellIsAvailable[i][j] = true;
    }
  }
  startCell = new Cell(0, 0);
  finishCell = new Cell(mazeRowCount - 1, mazeRowCount - 1);
}

void drawMaze() {
  //start at cell in upper left
  buildOnCell(startCell);
}

void buildOnCell(Cell cell) {
  Cell[] nbrs = scrambledNeighbors();
  //  boolean foundAvailableCell = false;
  for (Cell nbr : nbrs) {
    Cell nextCell = new Cell(cell.x + nbr.x, cell.y + nbr.y);
    if (nextCell.isAvailable()) {
      nextCell.markUnavailable();
      Link link = new Link(cell, nextCell);
      links.add(link);
      link.draw();
      if (!nextCell.isFinishCell())
        buildOnCell(nextCell);
    }
  }
}

Cell[] scrambledNeighbors() {
  Cell[] nbrs = new Cell[neighbors.length];
  arrayCopy(neighbors, nbrs);
  for (int i = 0; i < nbrs.length; ++i) {
    int rnd = i + (int) random(4-i);
    Cell swap = nbrs[rnd];
    nbrs[rnd] = nbrs[i];
    nbrs[i] = swap;
  }
  return nbrs;
}

class Cell {
  int x, y;

  Cell(int x_, int y_) {
    x=x_;
    y=y_;
  }

  //  void draw() {
  //    rect( (x + 0.5) * cellCenterToCenter, (y + 0.5) * cellCenterToCenter, cellWidth, cellWidth);
  //  }

  void markUnavailable() {
    cellIsAvailable[x][y] = false;
  }

  boolean isAvailable() {
    if (x < 0 || x >= cellIsAvailable[0].length || y < 0 || y >= cellIsAvailable.length) {
      return false;
    }
    return cellIsAvailable[x][y];
  }

  boolean isFinishCell() {
    return x == finishCell.x && y == finishCell.y;
  }

  boolean isStartCell() {
    return x == startCell.x && y == startCell.y;
  }
}

class Link {
  Cell c0, c1;

  Link(Cell c0_, Cell c1_) {
    c0=c0_;
    c1=c1_;
  }

  void draw() {
    line(c0.x, c0.y, c1.x, c1.y);
    //    rect( (x + 0.5) * cellCenterToCenter, (y + 0.5) * cellCenterToCenter, cellWidth, cellWidth);
  }
}
