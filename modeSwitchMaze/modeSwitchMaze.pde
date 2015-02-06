Maze maze;
float segmentLength;
int maxLength = -1;
boolean generateMaze = false;

void setup() {
  size(640, 480);
  segmentLength = width / 8;
}

void keyPressed() {
  generateMaze = true;
}

void draw() {
  if(!generateMaze) return;
  generateMaze = false;
  maze = new Maze();
  maze5();
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
    println(""+frameCount+" null");
  }
  println("maxLength = "+maxLength);
}

void maze1(Maze maze) {

  int mode0 = 0;
  int mode1 = 1;

  maze.addModeSegment(0, 0, 0, 1, mode0);
  maze.addSegment(0, 1, 0, 2);
  maze.addModeSegment(0, 2, 0, 3, mode1);

  maze.addModeSegment(0, 1, 1, 1, mode1);
  maze.addModeSegment(0, 2, 1, 2, mode0);
  maze.addSegment(0, 3, 1, 3);

  maze.addSegment(1, 1, 1, 2);
  maze.addModeSegment(1, 2, 1, 3, mode1);

  maze.addSegment(1, 1, 2, 1);
  maze.addModeSegment(1, 2, 2, 2, mode1);
  maze.addModeSegment(1, 3, 2, 3, mode0);

  maze.addModeSegment(2, 1, 2, 2, mode1);
  maze.addModeSegment(2, 2, 2, 3, mode0);

  maze.addSegment(2, 1, 3, 1);
  maze.addSegment(2, 2, 3, 2);
  maze.addSegment(2, 3, 4, 3);

  maze.addModeSegment(3, 1, 3, 2, mode0);
  maze.addModeSegment(3, 2, 4, 2, mode0);

  maze.addModeSegment(3, 1, 5, 1, mode1);
  maze.addSegment(4, 2, 4, 3);

  maze.addSegment(4, 2, 5, 2);
  maze.addModeSegment(5, 1, 5, 2, mode0);
  maze.addSegment(5, 2, 5, 3);
  maze.addModeSegment(4, 3, 5, 3, mode1);

  maze.addModeSegment(3, 1, 3, 0, mode1);

  maze.setEndVertex(3, 0);
}


void maze2(Maze maze) {
  //14 steps
  int mode0 = 0;
  int mode1 = 1;

  maze.addModeSegment(0, 0, 0, 1, mode0);
  maze.addSegment(0, 1, 0, 2);
  maze.addModeSegment(0, 2, 0, 3, mode1);

  maze.addModeSegment(0, 1, 1, 1, mode1);
  maze.addModeSegment(0, 2, 1, 2, mode0);
  maze.addSegment(0, 3, 1, 3);

  maze.addModeSegment(1, 1, 1, 2, mode1);
  maze.addModeSegment(1, 2, 1, 3, mode1);

  maze.addSegment(1, 1, 2, 1);
  maze.addModeSegment(1, 2, 2, 2, mode0);
  maze.addModeSegment(1, 3, 2, 3, mode0);

  maze.addModeSegment(2, 1, 2, 2, mode0);
  maze.addModeSegment(2, 2, 2, 3, mode0);

  maze.addSegment(2, 1, 3, 1);
  maze.addSegment(2, 2, 3, 2);
  maze.addSegment(2, 3, 4, 3);

  maze.addModeSegment(3, 1, 3, 2, mode0);
  maze.addModeSegment(3, 2, 4, 2, mode1);

  maze.addModeSegment(3, 1, 5, 1, mode1);
  maze.addSegment(4, 2, 4, 3);
  maze.addModeSegment(4, 3, 5, 3, mode1);

  maze.addModeSegment(4, 2, 5, 2, mode0);
  maze.addSegment(5, 1, 5, 2);
  maze.addModeSegment(5, 2, 5, 3, mode0);

  maze.addModeSegment(5, 3, 6, 3, mode1);

  maze.setEndVertex(6, 3);
}

int randMode() {
  return (int) (random(2));
}

void addRandomSegment(int x1, int y1, int x2, int y2) {
  if (random(1) < 0.3) {
    maze.addSegment(x1, y1, x2, y2);
  } 
  else {
    maze.addModeSegment(x1, y1, x2, y2, randMode());
  }
}

void maze3(Maze maze) {
  addRandomSegment(0, 0, 0, 1);
  addRandomSegment(0, 1, 0, 2);
  addRandomSegment(0, 2, 0, 3);

  addRandomSegment(0, 1, 1, 1);
  addRandomSegment(0, 2, 1, 2);
  addRandomSegment(0, 3, 1, 3);

  addRandomSegment(1, 1, 1, 2);
  addRandomSegment(1, 2, 1, 3);

  addRandomSegment(1, 1, 2, 1);
  addRandomSegment(1, 2, 2, 2);
  addRandomSegment(1, 3, 2, 3);

  addRandomSegment(2, 1, 2, 2);
  addRandomSegment(2, 2, 2, 3);

  addRandomSegment(2, 1, 3, 1);
  addRandomSegment(2, 2, 3, 2);
  addRandomSegment(2, 3, 4, 3);

  addRandomSegment(3, 1, 3, 2);
  addRandomSegment(3, 2, 4, 2);

  addRandomSegment(3, 1, 5, 1);
  addRandomSegment(4, 2, 4, 3);
  addRandomSegment(4, 3, 5, 3);

  addRandomSegment(4, 2, 5, 2);
  addRandomSegment(5, 1, 5, 2);
  addRandomSegment(5, 2, 5, 3);

  maze.addModeSegment(5, 3, 6, 3, randMode());

  maze.setEndVertex(6, 3);
}


void maze4(Maze maze) {
  addRandomSegment(0, 0, 0, 1);
  addRandomSegment(0, 1, 0, 2);
  addRandomSegment(0, 2, 0, 3);

  addRandomSegment(0, 1, 1, 1);
  addRandomSegment(0, 2, 1, 2);
  addRandomSegment(0, 3, 1, 3);

  addRandomSegment(1, 1, 1, 2);
  addRandomSegment(1, 2, 1, 3);

  addRandomSegment(1, 1, 2, 1);
  addRandomSegment(1, 2, 2, 2);
  addRandomSegment(1, 3, 2, 3);

  addRandomSegment(2, 1, 2, 2);
  addRandomSegment(2, 2, 2, 3);

  addRandomSegment(2, 1, 3, 1);
  addRandomSegment(2, 2, 3, 2);
  addRandomSegment(2, 3, 4, 3);

  addRandomSegment(3, 1, 3, 2);
  addRandomSegment(3, 2, 4, 2);

  addRandomSegment(3, 1, 5, 1);
  addRandomSegment(4, 2, 4, 3);
  addRandomSegment(4, 3, 5, 3);

  addRandomSegment(4, 2, 5, 2);
  addRandomSegment(5, 1, 5, 2);
  addRandomSegment(5, 2, 5, 3);

  for (int i = 0; i < 6; ++i) {
    addRandomSegment(i, 3, i, 4);
  }

  for (int i = 0; i < 5; ++i) {
    addRandomSegment(i, 4, i + 1, 4);
  }

  maze.addModeSegment(5, 3, 6, 3, randMode());

  maze.setEndVertex(6, 3);
}

void maze5() {
  maze.addModeSegment(0, 0, 0, 1, randMode());
  for (int i = 0; i < 6; ++i) {
    for (int j = 1; j < 5; ++j) {
      if (random(1)<2) {
        if (j < 4) {
          addRandomSegment(i, j, i, j + 1);
        }
        if (i < 5) {
          addRandomSegment(i, j, i + 1, j);
        }
      }
    }
  }
  maze.addModeSegment(5, 3, 6, 3, randMode());
  maze.setEndVertex(6, 3);
}
