class Die {
  int x;
  int y;
  int sideLength;
  int rollValue;
  
  Die() {
    rollValue=1;
  }
  
  void roll() {
    rollValue = (int) (1.0 + random(6));
  }

  void draw(int x_, int y_, int sideLength_) {
    x=x_;
    y=y_;
    sideLength=sideLength_;
    stroke(120);
    fill(255);
    rect(x, y, sideLength, sideLength, sideLength / 5);
    textSize(32);
    fill(0);
    if (rollValue == 1)
      drawDots(new int[] {  2, 2 } );
    else if (rollValue == 2) {
      // orientation of dots (upper left and lower right, or upper right and lower left)
      // is randomized. 
      int[] dots = random(1) < 0.5 ? new int[] {  1, 1, 3, 3 } : new int[] {  1, 3, 3, 1 };
      drawDots(dots);
    } 
    else if (rollValue == 3) {
      int[] dots = random(1) < 0.5 ? new int[] {   1, 1, 2, 2, 3, 3 } : new int[] {   1, 3, 2, 2, 3, 1 };
      drawDots(dots);
    } 
    else if (rollValue == 4) {
      drawDots(new int[] {
        1, 1, 1, 3, 3, 1, 3, 3
      }
      );
    } 
    else if (rollValue == 5) {
      drawDots(new int[] {
        1, 1, 1, 3, 3, 1, 3, 3, 2, 2
      }
      );
    } 
    else {
      int[] dots = random(1) < 0.5 ? new int[] { 1, 1, 1, 3, 2, 1, 2, 3, 3, 1, 3, 3} 
          : new int[] { 1, 1, 1, 2, 1, 3, 3, 1, 3, 2, 3, 3};
      drawDots(dots);
    }
  }

  void drawDots(int[] indices) {
    int dotSize  = sideLength / 6;
    int dotSpacing = sideLength/4;
    for (int i = 0; i < indices.length; i = i + 2) 
      ellipse(x + indices[i] * dotSpacing, y + indices[i+1] * dotSpacing, dotSize, dotSize);
  }
}

