class Maze {
  boolean[][] cellIsAvailable;
  Cell startCell;
  Cell finishCell;
  Link startLink;
  ArrayList<Link> links;
  ArrayList<Link> linksToBuildUpon;

  Maze() {
    cellIsAvailable = new boolean[mazeRowCount][mazeRowCount];

    createCircularGrid();

    links = new ArrayList<Link>();
    linksToBuildUpon = new ArrayList<Link>();
    linksToBuildUpon.add(startLink);

    while (!linksToBuildUpon.isEmpty ()) {
      buildOnLastLinkAdded();
    }
  }

  void createCircularGrid() {
    for (int i = 0; i < mazeRowCount; ++i) {
      for (int j = 0; j < mazeRowCount; ++j) {
        cellIsAvailable[i][j] = dist(i, j, (mazeRowCount - 1) * 0.5, (mazeRowCount - 1) * 0.5) <  (mazeRowCount * 0.5);
      }
    }
    startCell = new Cell(0, mazeRowCount/2);
    startCell.markUnavailable(cellIsAvailable);
    startLink = new Link(new Cell(-1, mazeRowCount/2), startCell);
    finishCell = new Cell(mazeRowCount - 1, mazeRowCount/2);
  }

  void createSquareGrid() {
    for (int i = 0; i < mazeRowCount; ++i) {
      for (int j = 0; j < mazeRowCount; ++j) {
        cellIsAvailable[i][j] = true;
      }
    }
    startCell = new Cell(0, 0);
    startCell.markUnavailable(cellIsAvailable);
    startLink = new Link(new Cell(-1, 0), startCell);
    finishCell = new Cell(mazeRowCount - 1, mazeRowCount - 1);
  }


  void buildOnLastLinkAdded() {
    Link link = linksToBuildUpon.get(linksToBuildUpon.size() - 1);
     int index = 0;
    Cell[] nextCells = new Cell[] {
      link.left(), link.right(), link.forward()
      };  

      //shuffle order of next cells  taken
    int[] nextCellIndices = new int[] {
      0, 1, 2
    };
    if (random(1) < 0.5) {
      nextCellIndices[0] = 1;
      nextCellIndices[1] = 0;
    }
    boolean hasAvailableNeighbors = false;
    float  PROBABILITY_TRYING_ZERO_NEIGHBORS = .95;
    for ( Cell nextCell : nextCells) {
      if (nextCell.isAvailable(cellIsAvailable)) {
        if (pow(random(1), 3) < PROBABILITY_TRYING_ZERO_NEIGHBORS) {
          //skip this cell for now
          hasAvailableNeighbors = true;
        } else {
          nextCell.markUnavailable(cellIsAvailable);
          Link newLink = new Link(link.c1, nextCell);
          links.add(newLink);
          if (!nextCell.isEqualTo(finishCell))
            linksToBuildUpon.add(newLink);
        }
      }
    }
    if (!hasAvailableNeighbors) {
      linksToBuildUpon.remove(link);
    }
  }


  void draw() {
    background(0); 
    float cellWidth = ((float) width) / (mazeRowCount + 1);
    scale(cellWidth, -cellWidth);
    translate(1, - mazeRowCount);
    strokeWeight(strokeWt);
    stroke(255);
    strokeCap(PROJECT);
    for (Link link : links) {
      link.draw();
    }
    noStroke();
    float dotSize = strokeWt * 0.6;
    fill(0, 255, 0);
    ellipse(startCell.x, startCell.y, dotSize, dotSize);
    fill(255, 0, 0);
    ellipse(finishCell.x, finishCell.y, dotSize, dotSize);
  }

  void drawGrid() {
    stroke(0);
    strokeWeight(0.05);
    for (int i = 0; i < mazeRowCount; ++i) {
      line(i - 0.25, -1, i - 0.25, mazeRowCount);
      line(i + 0.25, -1, i + 0.25, mazeRowCount);
      line(-1, i - 0.25, mazeRowCount, i - 0.25);
      line(-1, i + 0.25, mazeRowCount, i + 0.25);
    }
  }

  Link linkEndingAtCell(Cell cell) {
    for (Link link : links) {
      if (link.c1.x == cell.x && link.c1.y == cell.y) {
        return link;
      }
    }
    return null;
  }

  int solutionLength() {
    int cellsInPath = 0;
    Link currentLink = linkEndingAtCell(finishCell);
    while (currentLink.c0 != startCell) {
      ++cellsInPath;
      currentLink = linkEndingAtCell(currentLink.c0);
    }
    return cellsInPath;
  }
}
