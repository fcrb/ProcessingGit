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

