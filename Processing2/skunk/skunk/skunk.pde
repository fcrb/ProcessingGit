SkunkModel model;
boolean redraw = true;

void setup() {
  size(640, 480);
  model = new SkunkModel("Skunk");
}

void draw() {
  if (redraw) {
    background(200);
    for (SkunkLetter letter : model.getLetters()) {
      letter.draw();
    }
    redraw = false;
  }
}

void mouseReleased() {
  //background(50);
  redraw = true;
  if (model.isDone()) {
    model = new SkunkModel("Skunk");
  }
  else
    model.roll();
}  

class DicePair {
  Die die1;
  Die die2;

  DicePair() {
    die1 = new Die();
    die2 = new Die();
  }

  void roll() {
    die1.roll();
    die2.roll();
  }

  void draw(int x, int y, int sideLength) {
    die1.draw(x, y, sideLength);
    die2.draw(x + sideLength + sideLength / 10, y, sideLength);
  }

  boolean containsOne() {
    return die1.isOne() || die2.isOne();
  }
}

class Die {
  int x;
  int y;
  int sideLength;
  int rollValue;
  int[] dots;

  Die() {
    rollValue=1;
  }

  void roll() {
    rollValue = (int) (1.0 + random(6));
    if (rollValue == 1)
    dots = new int[] {  
      2, 2
    } 
    ;
    else if (rollValue == 2) {
      // orientation of dots (upper left and lower right, or upper right and lower left)
      // is randomized. 
      dots = random(1) < 0.5 ? new int[] {  
        1, 1, 3, 3
      } 
      : new int[] {  
        1, 3, 3, 1
      };
    } 
    else if (rollValue == 3) {
      dots = random(1) < 0.5 ? new int[] {   
        1, 1, 2, 2, 3, 3
      } 
      : new int[] {   
        1, 3, 2, 2, 3, 1
      };
    } 
    else if (rollValue == 4) {
      dots = new int[] { 
        1, 1, 1, 3, 3, 1, 3, 3
      } 
      ;
    } 
    else if (rollValue == 5) {
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
    return rollValue == 1;
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

class SkunkLetter {
  char c;
  float x;
  boolean aOneHasBeenRolled = false;
  ArrayList<DicePair> dicePairs;

  SkunkLetter(char c_, float x_) {
    c = c_;
    x = x_;
    dicePairs =  new ArrayList<DicePair>();
  }

  void draw() {
    fill(200);
    int textSize_ = height / 10;
    textSize(textSize_);
    int y = textSize_;
    y += 10;
    fill(0);
    text(c, x - textSize_/4, y );
    float dieSpaceFillFraction = 0.8;
    // 5 letters, 2 die, dieSpaceFillFraction of width
    int dieSideLength = (int) (width / 5.0 / 2 * dieSpaceFillFraction); 
    if (dieSideLength / dieSpaceFillFraction * (dicePairs.size()+1) + y > height) {
//      background(200);
      dieSideLength = (int) ((height - y )* dieSpaceFillFraction /( dicePairs.size()+1.0));
    }
    for (DicePair dice : dicePairs) {
      y += dieSideLength / dieSpaceFillFraction;
      dice.draw((int) x - dieSideLength, y, dieSideLength);
    }
  }

  void roll() {
    DicePair newPair = new DicePair();
    newPair.roll();
    dicePairs.add(newPair);
    if (!aOneHasBeenRolled)
      aOneHasBeenRolled = newPair.containsOne();
  }

  boolean isDone() {
    return aOneHasBeenRolled;
  }
}

class SkunkModel {
  SkunkLetter[] letters;

  SkunkModel(String nameOfGame) {
    letters = new SkunkLetter[nameOfGame.length()];
    int xSpace = width / (letters.length );
    for (int i = 0; i < letters.length; i++) 
      letters[i] = new SkunkLetter(nameOfGame.charAt(i), xSpace * (i + 0.5) );
  }

  SkunkLetter[] getLetters() {
    return letters;
  }

  void roll() {
    for (int i = 0; i < letters.length; i++) 
      if (!letters[i].isDone()) {
        letters[i].roll();
        return;
      }
  }

  boolean isDone() {
    return letters[letters.length-1].isDone();
  }
}


