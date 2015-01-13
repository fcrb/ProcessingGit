int mazeRowCount = 10;  //<>//
int mazesToPickFrom = 1; 
float strokeWt = 0.5;
boolean includeGrid = false;
Cell[] neighbors;
boolean redrawNeeded = true;

interface JavaScript {
  void showValues(int mazeRowCount);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;


void setNumberOfRows(int n) {
  if (n < 3) return;
  mazeRowCount = n;
  redrawNeeded = true;
}


void setup() {
  size(400, 400);
  neighbors = new Cell[4];
  neighbors[0] = new Cell(-1, 0);
  neighbors[1] = new Cell(1, 0);
  neighbors[2] = new Cell(0, -1);
  neighbors[3] = new Cell(0, 1);
}

void draw() {
  if (keyPressed) {
    if (key == '+') {
      setNumberOfRows(mazeRowCount+1);
    } else if (key == '-') {
      setNumberOfRows(mazeRowCount-1);
    }
  }

  if (!redrawNeeded) return;
  redrawNeeded = false;
  if (javascript!=null) 
    javascript.showValues(mazeRowCount);

  //find a good maze
  Maze bestMaze = null;
  int longestSolutionLength = -1;
  for (int i = 0; i < mazesToPickFrom; ++i) {
    Maze maze = new Maze();
    if (maze.solutionLength()>longestSolutionLength) {
      bestMaze = maze;
      longestSolutionLength = maze.solutionLength();
    }
  }
  background(100); 

  float cellWidth = width / (1.0 * mazeRowCount + 1.0);
  scale(cellWidth, -cellWidth);
  translate(1.0, - mazeRowCount);
  strokeWeight(strokeWt );
  stroke(255);
  strokeCap(PROJECT);
  bestMaze.draw();
  if (includeGrid) bestMaze.drawGrid();
}

class Cell {
  int x, y;

  Cell(int x_, int y_) {
    x=x_;
    y=y_;
  }

  void markUnavailable(boolean[] cellIsAvailable) {
    cellIsAvailable[y * mazeRowCount + x] = false;
  }

  boolean isAvailable(boolean[] cellIsAvailable) {
    if (x < 0 || x >= mazeRowCount || y < 0 || y >= mazeRowCount) {
      return false;
    }
    return cellIsAvailable[y * mazeRowCount + x];
  }

  boolean isEqualTo(Cell c) {
    return x == c.x && y == c.y;
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
  }

  Cell left() {
    return new Cell(c1.x + (c1.y - c0.y), c1.y + (c1.x - c0.x));
  }

  Cell right() {
    return new Cell(c1.x - (c1.y - c0.y), c1.y - (c1.x - c0.x));
  }

  Cell forward() {
    return new Cell(c1.x + (c1.x - c0.x), c1.y + (c1.y - c0.y));
  }
}
class Maze {
  boolean[] cellIsAvailable;//made 1-d to accommodate js
  Cell startCell;
  Cell finishCell;
  Link startLink;
  ArrayList<Link> links;
  ArrayList<Link> linksToBuildUpon;

  Maze() {
    cellIsAvailable = new boolean[mazeRowCount * mazeRowCount];

    //    createSquareGrid();
    createCircularGrid();

    links = new ArrayList<Link>();
    linksToBuildUpon = new ArrayList<Link>();
    linksToBuildUpon.add(startLink);

    while (!linksToBuildUpon.isEmpty ()) {
      buildOnLastLinkAdded();
    }
  }

  void draw() {
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


  void createCircularGrid() {
    int halfMazeRowCount = (int)(mazeRowCount / 2);
    float midCircle = (mazeRowCount - 1) * 0.5;
    for (int i = 0; i < mazeRowCount; ++i) {
      for (int j = 0; j < mazeRowCount; ++j) {
        cellIsAvailable[i * mazeRowCount + j] = dist(i, j, midCircle, midCircle) <  midCircle + 0.5001;
      }
    }
    startCell = new Cell(0, halfMazeRowCount);
    startCell.markUnavailable(cellIsAvailable);
    startLink = new Link(new Cell(-1, halfMazeRowCount), startCell);
    finishCell = new Cell(mazeRowCount - 1, halfMazeRowCount);
  }

  void createSquareGrid() {
    for (int i = 0; i < cellIsAvailable.length; ++i) {
      cellIsAvailable[i] = true;
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
    //    float  PROBABILITY_TRYING_ZERO_NEIGHBORS = .95;
    for ( Cell nextCell : nextCells) {
      if (nextCell.isAvailable(cellIsAvailable)) {
        if (random(1) < 0.95) {
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

  int solutionLength() {
    int cellsInPath = 0;
    Link currentLink = linkEndingAtCell(finishCell);
    while (currentLink.c0 != startCell) {
      ++cellsInPath;
      currentLink = linkEndingAtCell(currentLink.c0);
    }
    return cellsInPath;
  }

  Link linkEndingAtCell(Cell cell) {
    for (Link link : links) {
      if (link.c1.x == cell.x && link.c1.y == cell.y) {
        return link;
      }
    }
    return null;
  }
}
