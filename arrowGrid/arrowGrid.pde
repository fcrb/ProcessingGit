int gridSize = 25;
int possibleDirections = 8;
Cell[][] cells;

void setup() {
  size(640, 640);
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
  if(xCenter < 0 || yCenter < 0 || xCenter >= gridSize || yCenter >= gridSize) {
    return;
  }
  for (int x = 0; x < gridSize; ++x) {
    for (int y = 0; y < gridSize; ++y) {
      cells[x][y].rotated = false;
    }
  }
  cells[xCenter][yCenter].direction += 1;
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
  if(x >= 0 && x < gridSize && y >= 0 && y < gridSize) {
    cells[x][y].rotateArrowIfNecessary();
  }
  return;
}

//Cell getCell(int x, int y) { 
//  if (x >= 0 && x < gridSize && y >= 0 && y < gridSize) {
//    return cells[x][y];
//  }
//  return NULL_CELL;
//}


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

void addCell(int x, int y) {
  if (cells[x][y] != null) {
    return;
  }
  cells[x][y] = new Cell(x, y, 4);
  if (x > 0) {
    addCell(x-1, y);
  }
  if (x < gridSize - 1) {
    addCell(x+1, y);
  }
  if (y > 0) {
    addCell(x, y-1);
  }
  if (y < gridSize - 1) {
    addCell(x, y+1);
  }
}

class Cell {
  int x, y, direction;
  boolean rotated = false;

  Cell(int x_, int y_, int direction_) {
    x = x_;
    y=y_;
    direction=direction_;
  }

  void draw() {
    pushMatrix();
    float cellWidth_ = cellWidth();
    translate((x+0.5) * cellWidth_, (y+0.5) * cellWidth_);
    rectMode(CENTER);
    strokeWeight(1);
    int strokeAndFill = 220;
    stroke(220);
    fill(255);
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
      direction += (delta > 0) ? -1 : 1;
      direction = direction % possibleDirections;
      rotated = true;
    }
  }
}
