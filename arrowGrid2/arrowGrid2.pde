int gridSize = 3;
int possibleDirections = 8;
boolean useColor = false;
//directions 0-7 are multiplied by pi/4

int[] directionXDelta =  new int[] {
  1, 1, 0, -1, -1, -1, 0, 1
};
int[] directionYDelta = new int[] {  
  0, -1, -1, -1, 0, 1, 1, 1
};
Cell[][] cells;
int exitCellCount = 0;

void setup() {
  size(320, 320);
  reset();
}

void draw() {
  for (int x = 0; x < gridSize; ++x) {
    for (int y = 0; y < gridSize; ++y) {
      cells[x][y].draw();
    }
  }
}

void mousePressed() {
  int xCenter = mouseX / cellWidth();
  int yCenter = mouseY / cellWidth();
  //leave if mouseClick outside window
  if (xCenter < 0 || yCenter < 0 || xCenter >= gridSize || yCenter >= gridSize) {
    return;
  }
  //mark all cells as unrotated
  for (int x = 0; x < gridSize; ++x) {
    for (int y = 0; y < gridSize; ++y) {
      cells[x][y].clear();
    }
  }
  exitCellCount = 0;
  cells[xCenter][yCenter].direction += 
    (keyPressed && (key == CODED)&&(keyCode == SHIFT))? 1 : -1;
  cells[xCenter][yCenter].rotated = true;
  int xRight = xCenter;
  int xLeft = xCenter;
  int yTop = yCenter ;
  int yBottom = yCenter ;
  while (xLeft > 0 || xRight < gridSize - 1 || yTop > 0 || yBottom < gridSize - 1) {
    for (int i = xLeft; i <= xRight; ++i) {
      rotateArrow(i, yTop - 1);
    }
    for (int i = yTop; i <= yBottom; ++i) {
      rotateArrow(xRight + 1, i);
    }
    for (int i = xRight ; i >= xLeft; --i) {
      rotateArrow(i, yBottom+1);
    }
    for (int i = yBottom  ; i >= yTop; --i) {
      rotateArrow(xLeft-1, i);
    }
    //rotate the neighbors
    rotateArrow(xLeft-1, yTop-1);
    rotateArrow(xRight+1, yTop-1);
    rotateArrow(xLeft-1, yBottom+1);
    rotateArrow(xRight+1, yBottom+1);
    xLeft -= 1;
    xRight += 1;
    yTop -= 1;
    yBottom += 1;
  }
}

void rotateArrow(int x, int y) {
  if (x >= 0 && x < gridSize && y >= 0 && y < gridSize) {
    cells[x][y].rotateArrowIfNecessary();
  }
}

int cellWidth() {
  return width / gridSize;
}


void reset() {
  cells = new Cell[gridSize][gridSize];
  for (int x = 0; x < gridSize; ++x) {
    for (int y = 0; y < gridSize; ++y) {
      cells[x][y] = new Cell(x, y, 0);
    }
  }
}

class Cell {
  int x, y, direction;
  boolean rotated = false;
  Cell exitCell_ = null;
  color c = color(150);

  Cell(int x_, int y_, int direction_) {
    x = x_;
    y=y_;
    direction=direction_;
  }

  void clear() {
    rotated = false;
    exitCell_ = null;
  }

  void draw() {
    pushMatrix();
    float cellWidth_ = cellWidth();
    translate((x+0.5) * cellWidth_, (y+0.5) * cellWidth_);
    rectMode(CENTER);
    strokeWeight(1);
    int strokeAndFill = 220;
    stroke(220);
    fill(useColor ? exitCell().c : 255);
    rect(0, 0, cellWidth_, cellWidth_);
    rotate(- direction * PI * 0.25);
    float arrowScale = 0.4;
    strokeWeight(cellWidth_ * 0.05);
    strokeAndFill = 100;
    stroke(strokeAndFill);
    line(-cellWidth_*arrowScale, 0, cellWidth_ * arrowScale, 0);
    fill(strokeAndFill);
    float arrowBase = cellWidth_ *  arrowScale * 0.4;
    float arrowX = cellWidth_ *  arrowScale - arrowBase * sqrt(3) * 0.5;
    triangle(arrowX, arrowBase/2, arrowX, -arrowBase/2, cellWidth_ * arrowScale, 0);
    popMatrix();
  }

  Cell exitCell() {
    if (exitCell_ == null) {
      Cell nextCell_ = nextCell();
      if (nextCell_ == null) {
        exitCell_ = this;
        int cValue = exitCellCount * 10;
        c = (exitCellCount++ % 2 == 0) ? color(255, 255 - cValue, cValue)
        : color(255, cValue, 255 - cValue);
      } 
      else {
        exitCell_ = nextCell_.exitCell();
      }
    } 
    return exitCell_;
  }

  Cell nextCell() {
    direction = (direction + 8000) % 8;
    int nextX = x + directionXDelta[direction];
    int nextY = y + directionYDelta[direction];

    if (nextX >= 0 && nextX < gridSize && nextY >= 0 && nextY < gridSize) {
      return cells[nextX][nextY];
    }
    return null;
  }

  void rotateArrowIfNecessary() {
    if (rotated) {
      return;
    }
    if (x > 0) {
      rotateIfNeighborRequiresIt(cells[x-1][y] );
    }
    if (x < gridSize - 1) {
      rotateIfNeighborRequiresIt(cells[x+1][y] );
    }
    if (y > 0) {
      rotateIfNeighborRequiresIt(cells[x][y-1] );
    }
    if (y < gridSize - 1) {
      rotateIfNeighborRequiresIt(cells[x][y+1] );
    }
  }

  void rotateIfNeighborRequiresIt(Cell neighbor) {
    if (!neighbor.rotated ) {
      return;
    }
    int delta = direction - neighbor.direction;
    if (abs(delta) > 2) {
      delta += (delta > 0) ? - possibleDirections : possibleDirections;
    } 
    if (abs(delta) > 1) {
      direction += (delta > 0) ? 7 : 1;
      direction = direction % possibleDirections;
      rotated = true;
    }
  }
}
