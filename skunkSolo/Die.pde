class Die {
  int x;
  int y;
  int sideLength;
  int numberOfDots;
  int[] dots;

  Die() {
    numberOfDots=1;
  }

  void roll() {
    numberOfDots = (int) (1.0 + random(6));
    if (numberOfDots == 1)
    dots = new int[] {  
      2, 2
    } 
    ;
    else if (numberOfDots == 2) {
      // orientation of dots (upper left and lower right, or upper right and lower left)
      // is randomized. 
      dots = random(1) < 0.5 ? new int[] {  
        1, 1, 3, 3
      } 
      : new int[] {  
        1, 3, 3, 1
      };
    } 
    else if (numberOfDots == 3) {
      dots = random(1) < 0.5 ? new int[] {   
        1, 1, 2, 2, 3, 3
      } 
      : new int[] {   
        1, 3, 2, 2, 3, 1
      };
    } 
    else if (numberOfDots == 4) {
      dots = new int[] { 
        1, 1, 1, 3, 3, 1, 3, 3
      } 
      ;
    } 
    else if (numberOfDots == 5) {
      dots = new int[] {  
        1, 1, 1, 3, 3, 1, 3, 3, 2, 2
      };
    } 
    else {
      dots = random(1) < 0.5 ? new int[] { 
        1, 1, 1, 3, 2, 1, 2, 3, 3, 1, 3, 3
      } 
      : new int[] { 
        1, 1, 1, 2, 1, 3, 3, 1, 3, 2, 3, 3
      };
    }
  }

  boolean isOne() {
    return numberOfDots == 1;
  }

  int rollValue() {
    return numberOfDots;
  }

  void draw(int x_, int y_, int sideLength_) {
    x=x_;
    y=y_;
    sideLength=sideLength_;
    stroke(120);
    fill(255);
    rect(x, y, sideLength, sideLength, sideLength / 5);
    fill(0);
    float dotSize  = sideLength / 6.0;
    float dotSpacing = sideLength/4.0;
    for (int i = 0; i < dots.length; i = i + 2) 
      ellipse(x + dots[i] * dotSpacing, y + dots[i+1] * dotSpacing, dotSize, dotSize);
  }
}

