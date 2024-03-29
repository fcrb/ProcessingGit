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

