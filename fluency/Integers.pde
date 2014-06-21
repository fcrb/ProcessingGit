class Model {
  ArrayList<QuestionWithAnswer> questionsWithAnswers= new ArrayList<QuestionWithAnswer>(0);
  int[] sortedAnswers;
  QuestionWithAnswer currentQuestionWithAnswer;
  int score = 0;
  int missCount = 0;
  float time = 0;
  float startTime = millis();

  void addQuestionWithAnswer(QuestionWithAnswer newAnswer) {
    if (questionsWithAnswers.contains(newAnswer)) 
      return;
    questionsWithAnswers.add(newAnswer);
    sortedAnswers = null;
  }


  float elapsedTime() {
    if (!isComplete())
      time =(millis()-startTime) * 0.001;
    return time;
  }


  int[] getAnswers() {
    if (sortedAnswers == null) {
      sortedAnswers = new int[questionsWithAnswers.size()];
      int i = 0;
      for (QuestionWithAnswer q : questionsWithAnswers) {
        sortedAnswers[i++] = q.getAnswer();
      }
      sortedAnswers = sort(sortedAnswers);
    }
    return sortedAnswers;
  }

  QuestionWithAnswer getCurrentQuestion() {
    if (currentQuestionWithAnswer == null) 
      currentQuestionWithAnswer = questionsWithAnswers.get((int) random(questionsWithAnswers.size()));
    return currentQuestionWithAnswer;
  }

  int getMissCount() {
    return missCount;
  }

  int getQuestionCount() {
    return questionsWithAnswers.size();
  }

  boolean isComplete() {
    return questionsWithAnswers.size() == 0;
  }

  boolean isPerfect() {
    return isComplete() && getMissCount() == 0;
  }

  void reduceSizeTo(int n) {
    while (questionsWithAnswers.size () > n)
      questionsWithAnswers.remove((int) random(questionsWithAnswers.size()));
  }

  boolean tryAnswer(int answer) {
    if (answer == getCurrentQuestion().getAnswer()) {
      sortedAnswers = null;
      questionsWithAnswers.remove(currentQuestionWithAnswer);
      currentQuestionWithAnswer = null;
      return true;
    }
    else {
      ++missCount;
      return false;
    }
  }
}
// **** QuestionWithAnswer ********
class QuestionWithAnswer {
  String question;
  int answer;

  QuestionWithAnswer(String q, int a) {
    question = q;
    answer = a;
  }

  int getAnswer() {
    return answer;
  }

  String getQuestion() {
    return question;
  }

  String toString() {
    return question + answer;
  }

  boolean equals(Object o) {
    if (null == o) return false;
    if (!(o instanceof QuestionWithAnswer)) return false;
    QuestionWithAnswer other = (QuestionWithAnswer) o;
    return answer  == other.answer;
  }

  int hashCode() {
    return question.hashCode();
  }
}

// **** IntegerGameController ********
abstract class IntegerGameController extends GameController {
  Model model;

  int answerClicked() {
    int columnIndex = (int) (mouseX / distanceBetweenAnswers);
    int rowIndex = (int) ((mouseY - headerAndFooterHeight) / distanceBetweenAnswers);
    int answerIndex = rowIndex * answersPerRow() + columnIndex;
    if (answerIndex >= model.getAnswers().length)
      return 0;
    return getAnswer(answerIndex);
  }


  float elapsedTime() {
    return model.elapsedTime();
  }

  abstract QuestionWithAnswer generateQuestion();

  int getAnswer(int index) {
    return getAnswers()[index];
  }
  int[] getAnswers() {
    return model.getAnswers();
  }

  int getMissCount() {
    return model.getMissCount() ;
  }

  String getQuestion() {
    return model.getCurrentQuestion().getQuestion();
  }

  int getQuestionCount() {
    return model.getQuestionCount();
  }

  void handleMouseRelease() {
    if (model != null) {
      boolean answerCorrect = model.tryAnswer(answerClicked());
      //      printConsole("answer correct = " + answerCorrect + " isComplete = " + isComplete());
      if (answerCorrect) {
        //        printConsole("answer correct !");
        if (isComplete()) {
          //          printConsole("practice complete !");
          recordScore();
        }
      }
    }
  }

  boolean isComplete() {
    return model.isComplete();
  }

  boolean isPerfect() {
    return model.isPerfect();
  }

  void drawView() {
    drawBackgroundAndScore();
    if (isComplete()) {
      drawGameOverScreen();
      return;
    }

    //show question
    int questionSize = (int) (headerAndFooterHeight  * 0.8);
    textSize(questionSize);
    String question = getQuestion();
    if (textWidth(question)> 0.9 * width) {
      questionSize *= width * 0.9 / textWidth(question);
      textSize(questionSize);
    }
    text(question, (width - textWidth(question))/2, headerAndFooterHeight * 0.9);

    //draw grid and numbers
    int rowIndex = 0;
    int columnIndex = 0;
    stroke(bgColor());
    for (int answer : getAnswers()) {
      float upperLeftX = spaceBetweenTiles + columnIndex * distanceBetweenAnswers;
      float upperLeftY = spaceBetweenTiles + rowIndex * distanceBetweenAnswers+ headerAndFooterHeight; 
      //mouse near this answer? if so, decrease alpha
      if (mouseX > upperLeftX && mouseX < upperLeftX + tileWidth 
        &&mouseY > upperLeftY && mouseY < upperLeftY + tileWidth ) {
        fill(bgColor(), 150);
      } 
      else {
        fill(bgColor(), 50);
      }
      rect(upperLeftX, upperLeftY, tileWidth, tileWidth, tileWidth / 5);

      //draw answer
      fill(fontColor());
      int textSize_ = (int) (tileWidth * 0.5);
      textSize(textSize_);
      String answerStr = "" + answer;
      if (textWidth(answerStr)> 0.9 * tileWidth) {
        textSize_ *= tileWidth * 0.9 / textWidth(answerStr);
        textSize(textSize_);
      }
      text(answerStr, upperLeftX + (tileWidth - textWidth(answerStr)) / 2, -7+ upperLeftY +  (tileWidth + textSize_) / 2);

      ++columnIndex;
      if (columnIndex >= answersPerRow()) {
        columnIndex = 0;
        ++rowIndex;
      }
    }
  }

  void restart() {
    model = new Model();
    while (model.getQuestionCount () < answersPerRow() * answersPerRow()) {
      //      QuestionWithAnswer qa = currentController.generateQuestion();
      model.addQuestionWithAnswer(generateQuestion());
    }
    tileWidth = (width - (answersPerRow() + 1.0) * spaceBetweenTiles) / answersPerRow();
    distanceBetweenAnswers = tileWidth + spaceBetweenTiles;
    return;
  }
}

// **** AdditionOnlyController ********
class AdditionOnlyController extends IntegerGameController {

  String name() {
    return "add_pos_digits";
  }

  QuestionWithAnswer generateQuestion() {
    int n1 = (int)(random(1, 10));
    int n2 = (int)(random(1, 10));
    String q = "" + n1 +  "+" + n2 + "=";
    return new QuestionWithAnswer(q, n1 + n2 );
  }
}

// **** SubtractionOnlyController ********
class SubtractionOnlyController extends IntegerGameController {

  String name() {
    return "subtract_positive";
  }

  QuestionWithAnswer generateQuestion() {
    int n1 = (int)(random(3, 19));
    int n2 = (int)(random(1, n1-1));
    String q = "" + n1 + "-" + n2 + "=";
    return new QuestionWithAnswer(q, n1-n2 );
  }
}

// **** AdditionController ********
class AdditionController extends IntegerGameController {

  String name() {
    return "add_subtract_pos_neg";
  }

  QuestionWithAnswer generateQuestion() {
    int n1 = (int)(random(1, 10));
    if (random(1) < 0.5) n1 = -n1;
    int n2 = (int)(random(1, 10));
    if (random(1) < 0.5) n2 = -n2;
    boolean isAddition = random(1) < 0.5;
    String q = "" + n1 + (isAddition ? "+" : "-") + (n2 > 0 ? n2 : "(" + n2 + ")")+"=";
    return new QuestionWithAnswer(q, isAddition ? n1 + n2 : n1 - n2 );
  }
}

// **** TwoDigitAdditionController ********
class TwoDigitAdditionController extends IntegerGameController {

  String name() {
    return "two_digit_addition";
  }

  QuestionWithAnswer generateQuestion() {
    int n1 = 100, n2 = 100;
    while (n1 +n2 > 99) {
      n1 = (int)(random(10, 99));
      n2 = (int)(random(10, 99));
    }
    String q = "" + n1 + "+" + n2 +"=";
    return new QuestionWithAnswer(q, n1 + n2 );
  }
}

// **** GCFController ********
class GCFController extends IntegerGameController {
  int answersPerRow() {
    return 3;
  }

  String name() {
    return "gcf";
  }

  QuestionWithAnswer generateQuestion() {
    int n1 = (int)(random(2, 10)) *  (int)(random(2, 10));
    int n2 = n1;
    while (n2 == n1)
      n2 = (int)(random(2, 10)) *  (int)(random(2, 10));
    String q = "gcf(" + n1 + "," + n2+")=";
    return new QuestionWithAnswer(q, gcf(n1, n2) );
  }
}
int gcf(int a, int b) {
  if (a == b) return a;
  if (a < b) return gcf(b, a);
  return gcf(a-b, b);
}

// **** LCMController ********
class LCMController extends IntegerGameController {
  int answersPerRow() {
    return 3;
  }

  String name() {
    return "lcm";
  }

  QuestionWithAnswer generateQuestion() {
    int lcm=100, n1=1, n2=1;
    while (lcm > 99 || (n1==n2) || (n1 % n2 == 0) ) {
      n1 = (int)(random(1, 10)) *  (int)(random(2, 10));
      n2 = (int)(random(1, 10)) *  (int)(random(2, 10));
      lcm = n1 * n2 / gcf(n1, n2);
    }
    String q = "lcm(" + n1 + "," + n2+")=";
    return new QuestionWithAnswer(q, lcm );
  }
}

// **** MultiplicationController ********
class MultiplicationController extends IntegerGameController {

  String name() {
    return "multiplication";
  }

  QuestionWithAnswer generateQuestion() {
    int i = (int)(random(1, 12));
    int j = (int)(random(1, 12));
    String q = ""+i + timesSymbol + j + "=";
    return new QuestionWithAnswer(q, i * j);
  }
}

// **** MultiplyNegativesController ********
class MultiplyNegativesController extends IntegerGameController {

  String name() {
    return "multiply_negatives";
  }

  QuestionWithAnswer generateQuestion() {
    int i = (int)(random(1, 10)) * ((int)(random(2))*2 -1) ;
    int j = (int)(random(1, 10)) * ((int)(random(2))*2 -1) ;
    String iStr = i < 0 ? "("+i+")" : ""+i;
    String jStr = j < 0 ? "("+j+")": ""+j;
    String q = iStr + timesSymbol + jStr + "=";
    return new QuestionWithAnswer(q, i * j);
  }
}

// **** SquaresController ********
class SquaresController extends IntegerGameController {

  String name() {
    return "squares";
  }

  QuestionWithAnswer generateQuestion() {
    int i = (int)(random(1, 25));
    String q = ""+i + timesSymbol + i + "=";
    return new QuestionWithAnswer(q, i * i);
  }
}

// **** ModulusController ********
class ModulusController extends IntegerGameController {
  int answersPerRow() {
    return 3;
  }

  String name() {
    return "modulus";
  }

  QuestionWithAnswer generateQuestion() {
    int i = (int)(random(10, 70));
    int j = (int)(random(10, 70));
    int m = (int)(random(2, 10));
    String q = "("+i + timesSymbol + j + ") mod " + m + equivSymbol;
    return new QuestionWithAnswer(q, (i * j) % m);
  }
}
// **** ModulusNineController ********
class ModulusNineController extends IntegerGameController {
  int answersPerRow() {
    return 3;
  }

  String name() {
    return "modulus_9";
  }

  QuestionWithAnswer generateQuestion() {
    int i = (int)(random(10, 99));
    int j = (int)(random(10, 99));
    int m = 9;
    String q = "("+i + timesSymbol + j + ") mod " + m + equivSymbol;
    return new QuestionWithAnswer(q, (i * j) % m);
  }
}
