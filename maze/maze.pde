int mazeRowCount = 30;  //<>//
int mazesToPickFrom = 10; 
float strokeWt = 0.5;
boolean includeGrid = true;

Cell[] neighbors;

void setup() {
  size(800, 800);
  neighbors = new Cell[] { 
    new Cell(-1, 0), new Cell(1, 0), new Cell(0, -1), new Cell(0, 1)
    };

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
  println(bestMaze.solutionLength());
  bestMaze.draw();
  if (includeGrid) bestMaze.drawGrid();
}

class Cell {
  int x, y;

  Cell(int x_, int y_) {
    x=x_;
    y=y_;
  }

  void markUnavailable(boolean[][] cellIsAvailable) {
    cellIsAvailable[x][y] = false;
  }

  boolean isAvailable(boolean[][] cellIsAvailable) {
    if (x < 0 || x >= cellIsAvailable[0].length || y < 0 || y >= cellIsAvailable.length) {
      return false;
    }
    return cellIsAvailable[x][y];
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
