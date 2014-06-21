Maze maze;
float segmentLength;
int maxLength = -1;
boolean updateDraw = false;

void setup() {
  size(640, 480);
  segmentLength = width / 8;
  createMaze(5, 6);
}

void mousePressed() {
  maze.handleMouse();
  updateDraw = true;
}

void draw() {
  if (!updateDraw) return;
  updateDraw = false;

  maze.draw();
  Path minSolution = maze.shortestSolution();

  if (minSolution != null) {
    minSolution.displayString();
    if (minSolution.length() > maxLength) {
      maxLength = minSolution.length();
      minSolution.displayString();
    }
  } 
  else {
    println("no solution");
  }
}

int randomMode() {
  return (int) (random(2));
}

void addRandomSegment(int x1, int y1, int x2, int y2) {
  if (random(1) < 0.3) {
    maze.addSegment(x1, y1, x2, y2);
  } 
  else {
    maze.addModeSegment(x1, y1, x2, y2, randomMode());
  }
}

void createMaze(int rows, int columns) {
  maze = new Maze();
  maze.addModeSegment(0, 0, 0, 1, randomMode());
  for (int i = 0; i < columns; ++i) {
    for (int j = 1; j < (rows + 1); ++j) {
      if (random(1)<2) {
        if (j < rows) {
          addRandomSegment(i, j, i, j + 1);
        }
        if (i < columns - 1) {
          addRandomSegment(i, j, i + 1, j);
        }
      }
    }
  }
  maze.addModeSegment(5, 3, 6, 3, randomMode());
  maze.setEndVertex(6, 3);
}
