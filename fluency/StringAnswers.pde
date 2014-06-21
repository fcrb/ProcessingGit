class StringAnswerModel {
  ArrayList<QuestionWithStringAnswer> questionsWithAnswers= new ArrayList<QuestionWithStringAnswer>(0);
  String[] sortedAnswers;
  QuestionWithStringAnswer currentQuestionWithAnswer;
  int score = 0;
  int missCount = 0;
  float time = 0;
  float startTime = millis();

  void addQuestionWithAnswer(QuestionWithStringAnswer newAnswer) {
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


  String[] getAnswers() {
    if (sortedAnswers == null) {
      sortedAnswers = new String[questionsWithAnswers.size()];
      int i = 0;
      for (QuestionWithStringAnswer q : questionsWithAnswers) {
        sortedAnswers[i++] = q.getAnswer();
      }
      sortedAnswers = sort(sortedAnswers);
    }
    return sortedAnswers;
  }

  QuestionWithStringAnswer getCurrentQuestion() {
    if (currentQuestionWithAnswer == null) {
      currentQuestionWithAnswer = questionsWithAnswers.get((int) random(questionsWithAnswers.size()));
    }
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

  boolean tryAnswer(String answer) {
    if (answer.equals(getCurrentQuestion().getAnswer())) {
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
// **** QuestionWithStringAnswer ********
class QuestionWithStringAnswer {
  String question;
  String answer;

  QuestionWithStringAnswer(String q, String a) {
    question = q;
    answer = a;
  }

  String getAnswer() {
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
    if (!(o instanceof QuestionWithStringAnswer)) return false;
    QuestionWithStringAnswer other = (QuestionWithStringAnswer) o;
    return question.equals(other.question);
  }

  int hashCode() {
    return question.hashCode();
  }
}

// **** StringGameController ********
abstract class StringGameController extends GameController {
  StringAnswerModel model;

  String answerClicked() {
    int columnIndex = (int) (mouseX / distanceBetweenAnswers);
    int rowIndex = (int) ((mouseY - headerAndFooterHeight) / distanceBetweenAnswers);
    int answerIndex = rowIndex * answersPerRow() + columnIndex;
    if (answerIndex >= model.getAnswers().length)
      return "";
    return getAnswer(answerIndex);
  }


  float elapsedTime() {
    return model.elapsedTime();
  }

  abstract QuestionWithStringAnswer generateQuestion();

  String getAnswer(int index) {
    return getAnswers()[index];
  }
  String[] getAnswers() {
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
    float maxWidthFraction = 0.8;
    int  textSize_ = (int) (headerAndFooterHeight  * maxWidthFraction);
    textSize( textSize_);
    String question = getQuestion();
    float textWidth_ = textWidth(question);
    if (textWidth_ > width * maxWidthFraction) {
      textSize_ = (int) (textSize_ * width * maxWidthFraction / textWidth_);
      textSize(textSize_);
      textWidth_ = textWidth(question);
    };
    text(question, (width - textWidth(question))/2, headerAndFooterHeight * 0.9);

    //draw grid and numbers
    textSize( (int) (headerAndFooterHeight  * 0.8));
    int rowIndex = 0;
    int columnIndex = 0;
    stroke(bgColor());
    for (String answer : getAnswers()) {
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
      textSize_ = (int) (tileWidth * 0.5);
      textSize(textSize_);
      textWidth_ = textWidth(answer);
      if (textWidth_ > tileWidth * maxWidthFraction) {
        textSize_ = (int) (textSize_ * tileWidth * maxWidthFraction / textWidth_);
        textSize(textSize_);
        textWidth_ = textWidth(answer);
      };
      text(answer, upperLeftX + (tileWidth - textWidth(answer)) / 2, -7+ upperLeftY +  (tileWidth + textSize_) / 2);

      ++columnIndex;
      if (columnIndex >= answersPerRow()) {
        columnIndex = 0;
        ++rowIndex;
      }
    }
  }

  void restart() {
    model = new StringAnswerModel();
    while (model.getQuestionCount () < answersPerRow() * answersPerRow()) {
      //      QuestionWithAnswer qa = currentController.generateQuestion();
      model.addQuestionWithAnswer(generateQuestion());
    }
    tileWidth = (width - (answersPerRow() + 1.0) * spaceBetweenTiles) / answersPerRow();
    distanceBetweenAnswers = tileWidth + spaceBetweenTiles;
    return;
  }
}

// **** FactoringController ********
class FactoringController extends StringGameController {

  String name() {
    return "factoring";
  }

  QuestionWithStringAnswer generateQuestion() {
    int i = (int)(random(2, 10));
    int j = (int)(random(2, 10));
    if (i > j) return generateQuestion();
    String q = ""+i + timesSymbol + j;
    return new QuestionWithStringAnswer(""+(i * j), q);
  }
}
// **** BinaryController ********
class BinaryController extends StringGameController {
  int answersPerRow() {
    return 3;
  }

  String name() {
    return "binary";
  }

  QuestionWithStringAnswer generateQuestion() {
    int i = (int)(random(0, 16));
    String a = "000"+binary(i);
    a = a.substring(a.length() - 4, a.length());
    String q = ""+i + " base 10 = ? base 2";
    return new QuestionWithStringAnswer(q, a);
  }
}
// **** BinaryController ********
class LogBaseTenController extends StringGameController {
  int answersPerRow() {
    return 3;
  }

  String name() {
    return "log10";
  }

  QuestionWithStringAnswer generateQuestion() {
    int m = (int)(random(1, 10));
    int e = (int)(random(0, 6));
    String[] logs = new String[]{".00", ".30", ".48", ".60", ".70", ".78", ".85", ".90", ".95"};
    int x = m;
    for(int i = 0; i < e; ++i) {
      x *= 10;
    }
    String q = "log "+ x +" =";
    String a = ""+ e + logs[m -1 ];
    return new QuestionWithStringAnswer(q, a);
  }
}
