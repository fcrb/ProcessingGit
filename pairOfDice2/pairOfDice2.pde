Die die1;
Die die2;

class Die {
  int x;
  int y;
  int sideLength;
  int dotSize;

  Die(int x, int y, int sideLength) {
    this.x = x;
    this.y = y;
    this.sideLength = sideLength;
    this.dotSize  = sideLength / 6;
  }

  void draw() {
    stroke(120);
    fill(255);
    rect(x, y, sideLength, sideLength, sideLength / 5);
    int roll = (int) (1.0 + random(6));
    textSize(32);
    fill(0);
    if (roll == 1)
    drawDots(new int[] {
      2, 2
    }
    );
    else if (roll == 2) {
      drawDots(new int[] {
        1, 1, 3, 3
      }
      );
    } 
    else if (roll == 3) {
      drawDots(new int[] {
        1, 1, 2, 2, 3, 3
      }
      );
    } 
    else if (roll == 4) {
      drawDots(new int[] {
        1, 1, 1, 3, 3, 1, 3, 3
      }
      );
    } 
    else if (roll == 5) {
      drawDots(new int[] {
        1, 1, 1, 3, 3, 1, 3, 3, 2, 2
      }
      );
    } 
    else {
      drawDots(new int[] {
        1, 1, 1, 3, 2, 1, 2, 3, 3, 1, 3, 3
      }
      );
    }
  }

  void drawDots(int[] indices) {
    int dotSpacing = sideLength/4;
    for (int i = 0; i < indices.length; i = i + 2) 
      ellipse(x + indices[i] * dotSpacing, x + indices[i+1] * dotSpacing, dotSize, dotSize);
  }
}

void setup() {
  size(240, 120);
  setBackground();
  die1 = new Die(10, 10, 100);
  die2 = new Die(130, 10, 100);
  textSize(32);
  text("Click to roll.", 30, 70);
}

void draw() {
}  

void mousePressed() {
  setBackground();
}  

void mouseReleased() {
  setBackground();
  die1.draw();
  die2.draw();
}  

void setBackground() {
  background(50);
}


