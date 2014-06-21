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
    if(roll == 1)
      drawCenterDot();
    else if (roll == 2) {
      drawUpperLeftDot();
      drawLowerRightDot();
    } else if (roll == 3) {
      drawUpperLeftDot();
      drawCenterDot();
      drawLowerRightDot();
    } else if (roll == 4) {
      drawUpperLeftDot();
      drawLowerLeftDot();
      drawUpperRightDot();
      drawLowerRightDot();
    } else if (roll == 5) {
      drawUpperLeftDot();
      drawLowerLeftDot();
      drawCenterDot();
      drawUpperRightDot();
      drawLowerRightDot();
    } else  {
      drawUpperLeftDot();
      drawLowerLeftDot();
      drawUpperRightDot();
      drawLowerRightDot();
      ellipse(x+sideLength/4, y+sideLength/2, dotSize, dotSize);
      ellipse(x+sideLength*3/4, y+sideLength/2, dotSize, dotSize);
    } 
   }

  void drawCenterDot(){
      ellipse(x+sideLength/2, y+sideLength/2, dotSize, dotSize);
  }  

  void drawUpperLeftDot(){
      ellipse(x+sideLength/4, y+sideLength/4, dotSize, dotSize);
  }  

  void drawUpperRightDot(){
      ellipse(x+sideLength*3/4, y+sideLength/4, dotSize, dotSize);
  }  

  void drawLowerRightDot(){
      ellipse(x+sideLength*3/4, y+sideLength*3/4, dotSize, dotSize);
  }  

  void drawLowerLeftDot(){
      ellipse(x+sideLength/4, y+sideLength*3/4, dotSize, dotSize);
  }  
}

void setup() {
  size(240,120);
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
  


