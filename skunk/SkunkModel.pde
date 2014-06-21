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

