
// **** ReduceFractionsController ********
class ReduceFractionsController extends GameController {
  FractionModel model;
  Fraction answerClicked() {
    int columnIndex = (int) (mouseX / distanceBetweenAnswers);
    int rowIndex = (int) ((mouseY - headerAndFooterHeight) / distanceBetweenAnswers);
    int answerIndex = rowIndex * answersPerRow() + columnIndex;
    if (answerIndex >= model.getAnswers().length)
      return null;
    return model.getAnswer(answerIndex);
  }

  void drawView() {
    drawBackgroundAndScore();
    if (isComplete()) {
      drawGameOverScreen();
      return;
    }

    //show question
    textSize( (int) (headerAndFooterHeight  * 0.8));
    Fraction question = model.getCurrentQuestion();
    drawFraction(question, 0, 0, width, headerAndFooterHeight * 0.55);

    //draw grid and numbers
    textSize( (int) (headerAndFooterHeight  * 0.8));
    int rowIndex = 0;
    int columnIndex = 0;
    stroke(fontColor());
    for (Fraction answer : model.getAnswers()) {
      //draw tile 
      float upperLeftX = spaceBetweenTiles + columnIndex * distanceBetweenAnswers;
      float upperLeftY = spaceBetweenTiles + rowIndex * distanceBetweenAnswers+ headerAndFooterHeight; 
      if (mouseX > upperLeftX && mouseX < upperLeftX + tileWidth 
        &&mouseY > upperLeftY && mouseY < upperLeftY + tileWidth ) {
        fill(bgColor(), 150);
      } 
      else {
        fill(bgColor(), 50);
      }
      strokeWeight(1);
      rect(upperLeftX, upperLeftY, tileWidth, tileWidth, tileWidth / 5);

      drawFraction(answer, upperLeftX, upperLeftY, tileWidth, tileWidth * 0.5);

      ++columnIndex;
      if (columnIndex >= answersPerRow()) {
        columnIndex = 0;
        ++rowIndex;
      }
    }
  }


  //w is the width of the drawing target, and is needed for centering. 
  void drawFraction(Fraction f, float upperLeftX_, float upperLeftY_, float w, float txtSize_) {
    //draw answer
    fill(fontColor());
    textSize((int) txtSize_);
    String   str = "" + f.getNumerator();
    if (f.getDenominator()==1 ) {
      text(str, upperLeftX_ + (w - textWidth(str)) / 2, upperLeftY_ +  1.35 * txtSize_);
      return;
    }
    float divisionX = upperLeftX_ + (w - textWidth(str)) / 2;
    text(str, divisionX, upperLeftY_ +  0.85 * txtSize_);
    float divisionY = upperLeftY_ + txtSize_;
    pushMatrix();
    stroke(fontColor());
    strokeWeight(2);
    line(divisionX, divisionY, divisionX + textWidth(str), divisionY);
    popMatrix();
    str = "" + f.getDenominator();
    text(str, upperLeftX_ + (w - textWidth(str)) / 2, upperLeftY_ +  1.85 * txtSize_);
  }

  float elapsedTime() {
    return model.elapsedTime();
  }

  int getMissCount() {
    return model.getMissCount();
  }
  
  int getQuestionCount() {
    return model.getQuestionCount();
  }

  void handleMouseRelease() {
    if (model.isComplete()) {
      restart();
      return;
    }
    if (model.tryAnswer(answerClicked()) && model.isComplete())
      recordScore();
  }
  
  boolean isComplete() {
    return model.isComplete();
  }
  
  boolean isPerfect() {
    return model.isPerfect();
  }

  String name() {
    return "reduce_fractions";
  }

  void restart() {
    model = new FractionModel();
    while (model.getQuestionCount () < answersPerRow() * answersPerRow()) {
      int i = (int) random(2, 10);
      int j = i;
      while (j == i)
        j = (int) random(2, 10);
      int k = (int) random(2, 10);
      model.addFraction(new Fraction(i * k, j * k));
    }
    tileWidth = (width - (answersPerRow() + 1.0) * spaceBetweenTiles) / answersPerRow();
    distanceBetweenAnswers = tileWidth + spaceBetweenTiles;
  }
}

public class Fraction implements Comparable<Fraction> {
  int num;
  int den;

  Fraction (int num_, int den_) {
    num = num_;
    den = den_;
  }

  boolean equals( Object other ) {
    if (other == null) return false;
    if (!(other instanceof Fraction)) return false;
    Fraction o = (Fraction) other;
    return o.num * den == o.den * num;
  }  

  int compareTo(Fraction f_) {
    if (num != f_.num )
      return (int) (num  - f_.num) ;
    return (int)(den  - f_.den) ;
  }

  int getDenominator() {
    return den;
  }

  int getNumerator() {
    return num;
  }

  Fraction reduce() {
    int gcf_ = gcf(num, den);
    //    println("gcf("+num+","+den+")="+gcf);
    int newNum = num / gcf_;
    int newDen = den / gcf_;
    return new Fraction (newNum, newDen);
  }

  int gcf(int a, int  b) {
    if (a == b) return a;
    if (a > b) return gcf(b, a);
    return gcf( a, b - a);
  }

  boolean isInteger() {
    return reduce().getDenominator() == 1;
  }

  String toString() {
    return num + "/" + den;
  }
}

// ******** class FractionModel **************
class FractionModel {
  ArrayList<Fraction> fractions= new ArrayList<Fraction>(0);
  Fraction[] sortedAnswers = null;
  Fraction currentQuestionWithAnswer;
  int score = 0;
  int missCount = 0;
  float time = 0;
  long startTime = millis();

  void addFraction(Fraction f) {
    if (fractions.contains(f)) return;
    fractions.add(f);
    sortedAnswers = null;
  }

  Fraction[] getAnswers() {
    if  (sortedAnswers == null) {
      sortedAnswers = new Fraction[fractions.size()];
      for (int i = 0; i < fractions.size(); ++i) {
        sortedAnswers[i] = fractions.get(i).reduce();
      }
      quicksort(0, sortedAnswers.length -1);
    }
    return sortedAnswers;
  }

  private void quicksort(int low, int high) {
    int i = low;
    int j = high;
    // Get the pivot element from the middle of the list
    // THE CAST IS NECESSARY FOR JAVASCRIPT!!! Can you believe it?
    Fraction pivot = sortedAnswers[(int)(low + (high-low)/2)];
    // Divide into two lists
    while (i <= j) {
      // If the current value from the left list is smaller then the pivot
      // element then get the next element from the left list
      while (sortedAnswers[i].compareTo (pivot) < 0) 
        i++;

      // element then get the next element from the right list
      while (sortedAnswers[j].compareTo (pivot) > 0) 
        j--;

      // If we have found a values in the left list which is larger then
      // the pivot element and if we have found a value in the right list
      // which is smaller then the pivot element then we exchange the
      // values.
      // As we are done we can increase i and j
      if (i <= j) {
        Fraction temp = sortedAnswers[i];
        sortedAnswers[i] =  sortedAnswers[j];
        sortedAnswers[j] = temp;
        i++;
        j--;
      }
    }
    // Recursion
    if (low < j)
      quicksort(low, j );
    if (i < high)
      quicksort(i, high );
  }


  Fraction getAnswer(int index) {
    return getAnswers()[index];
  }

  Fraction getCurrentQuestion() {
    if (currentQuestionWithAnswer == null) 
      currentQuestionWithAnswer = fractions.get((int) random(fractions.size()));
    return currentQuestionWithAnswer;
  }

  int getMissCount() {
    return missCount;
  }

  int getQuestionCount() {
    return fractions.size();
  }

  boolean isComplete() {
    return fractions.size() == 0;
  }

  boolean isPerfect() {
    return isComplete() && getMissCount() == 0;
  }

  void reduceSizeTo(int n) {
    while (fractions.size () > n)
      fractions.remove((int) random(fractions.size()));
  }


  boolean tryAnswer(Fraction answer) {
    if (answer == null)
      return true;
    if (answer.equals(getCurrentQuestion())) {
      sortedAnswers = null;
      fractions.remove(currentQuestionWithAnswer);
      currentQuestionWithAnswer = null;
      return true;
    }
    else {
      ++missCount;
      return false;
    }
  }

  float elapsedTime() {
    if (!isComplete())
      time =(millis()-startTime) * 0.001;
    return time;
  }
}
