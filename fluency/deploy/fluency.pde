GameController currentController;
GameController nullController;
String userName_;
HashMap<String, GameController>  controllers;
ArrayList<GameController>  gameControllers;

float spaceBetweenTiles = 10.0;
float headerAndFooterHeight = 60;
float tileWidth;
float distanceBetweenAnswers;
int answersPerRow;
String timesSymbol = "\u00D7";

ArrayList<TraceBall> tracers;
int numTracers = 80;

void setup() {
  size(400, 520);
  controllers = new HashMap<String, GameController>();
  gameControllers = new ArrayList<GameController>();

  addController(new NullController());
  addController(new AdditionController());
  addController(new GCFController()); 
  addController(new LCMController()); 
  addController(new MultiplicationController()); 
  currentController = addController(new FactoringController()); 
  addController(new MultiplyNegativesController()); 
  addController(new ReduceFractionsController()); 
  addController(new SquaresController()); 
  addController(new TwoDigitAdditionController()); 

  if (inJavascriptMode()) {
    currentController = nullController;
  }
  currentController.restart();

  tracers = new ArrayList<TraceBall>();
  for (int i = 0 ; i < numTracers; ++i) {
    float easing = (i  + 20.0 ) / (  numTracers + 30.0);
    tracers.add(new TraceBall( easing));
  }
  frameRate(30);
}

void draw() {
  currentController.drawView();
}

GameController addController(GameController c) {
  gameControllers.add(c);
  if (c.name().length() > 0)
    controllers.put(c.name(), c);
  return c;
}

void console(String s) {
  if (!inJavascriptMode())
    println(s);
}

boolean inJavascriptMode() {
//  String test = "" + 1.0;
//  return test.equals("1");
    return true;
}

void mouseReleased() {
  currentController.handleMouseRelease();
}


void restart() {
  currentController.restart();
}

String roundFloat(float f, int numPlaces) {
  int wholePart = (int) f;
  float fracPart = f - wholePart;
  for (int i = 0; i < numPlaces; ++i)
    fracPart *= 10;
  fracPart += 0.5;
  String fracPartOfAnswer = "" + round(fracPart);
  while (fracPartOfAnswer.length () < numPlaces)
    fracPartOfAnswer ="0"+fracPartOfAnswer;
  return "" + wholePart + "." + fracPartOfAnswer;
}


void selectPractice(String controllerName) {
  console(controllerName);
  GameController selectedController = controllers.get(controllerName);
  console(""+selectedController);
  if (selectedController == null)
    return;
  currentController = selectedController;
  currentController.restart();
}

String userName() {
  if (!inJavascriptMode())
    userName_ = "";   
  if (userName_ == null) {
    String lines[] = loadStrings("mrb_username.php");
    if (lines.length > 0) {
      userName_ = lines[0];
    } 
    else { 
      userName_ = "";
    }
  }
  return userName_;
}

abstract class GameController { //<>//
  abstract void drawView();
  abstract float elapsedTime();  
  abstract int getMissCount();  
  abstract int getQuestionCount();  
  abstract void handleMouseRelease();
  abstract boolean isComplete();
  abstract boolean isPerfect();
  abstract String name();
  void recordScore() {
    console("recordScore");
    //if (!deployed()) return;
    if (userName().equals("")) return;
    String putScoreURL = "record_score.php?";
    putScoreURL += "practice="+name();
    putScoreURL += "&score="+getMissCount();
    putScoreURL += "&time="+elapsedTime();
    console(putScoreURL);
    loadStrings(putScoreURL);
  }

  void drawBackgroundAndScore() {    
    background(255);
    int textSize_ = (int) (headerAndFooterHeight * 0.3);
    textSize(textSize_);
    fill(fontColor());
    for (TraceBall tracer : tracers)
      tracer.drawBall();

    //show user
    text("user: "+userName(), spaceBetweenTiles, height - spaceBetweenTiles*1.5 - textSize_);

    //show time
    text("time: "+roundFloat(elapsedTime(), 3), spaceBetweenTiles, height - spaceBetweenTiles);

    //show score
    String scoreMsg = "missed: "+getMissCount();
    text(scoreMsg, (width  - textWidth(scoreMsg))/2, height - spaceBetweenTiles);
    scoreMsg = "remaining: "+getQuestionCount();
    text(scoreMsg, width  - textWidth(scoreMsg) - spaceBetweenTiles, height - spaceBetweenTiles);
  }

  void drawGameOverScreen() {
    //do victory dance
    String msg = isPerfect() ? "Perfect!" : "Done!";
    int msgHeight = width / msg.length() ;
    textSize(msgHeight);
    text(msg, (width - textWidth(msg)) /2, (height - msgHeight) / 2);
  }

  void scoreReport() {
    if (!userName().equals("")) return;

    textSize(14);
    //    JSONArray rows = loadJSONArray("get_scores.php");
    //    int rowY = height / 5;
    //    for (int i = 0; i < values.size(); i++) {
    //      JSONObject row = rows.getJSONObject(i); 
    //      //{"practice":"addition", "score":"1", "duration":"25.582000732422", "date":"2013-11-19", "time":"00:04:22"},
    //      //      String practice = row.getString("practice");
    //      text(row.getString("practice"), 20, rowY );
    //      //      int score = Integer.parseInteger(row.getString("score"));
    //      text(row.getString("score"), 40, rowY );
    //      //      float duration = Float.parseFloat(row.getString("duration"));
    //      text(row.getString("duration"), 60, rowY );
    //      //      String date = row.getString("date");
    //      text(row.getString("date"), 80, rowY );
    //      rowY += 20;
    //    }
  }    

  abstract void restart();
}

float colorValue() {
  return 220+35*sin(millis() * 0.0005);
}
color bgColor() {
  return color(0, colorValue(), 400-colorValue());
}
color fontColor() {
  return color(0, colorValue() / 2, (400-colorValue())/2);
}


// **** NullController ********
class NullController extends GameController {
  void drawView() {
    background(255);
    scoreReport();
  }
  float elapsedTime() {
    return 0;
  }
  int getMissCount() {
    return 0;
  }
  int getQuestionCount() {
    return 0;
  }
  void handleMouseRelease() {
  }
  boolean isComplete() {
    return true;
  }
  boolean isPerfect() {
    return true;
  }
  String name() {
    return "";
  }
  void restart() {
  }
}

// **** ReduceFractionsController ********
class ReduceFractionsController extends GameController {
  FractionModel model;
  Fraction answerClicked() {
    int columnIndex = (int) (mouseX / distanceBetweenAnswers);
    int rowIndex = (int) ((mouseY - headerAndFooterHeight) / distanceBetweenAnswers);
    int answerIndex = rowIndex * answersPerRow + columnIndex;
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
      if (columnIndex >= answersPerRow) {
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
    answersPerRow = 4;
    while (model.getQuestionCount () < answersPerRow * answersPerRow) {
      int i = (int) random(2, 10);
      int j = i;
      while (j == i)
        j = (int) random(2, 10);
      int k = (int) random(2, 10);
      model.addFraction(new Fraction(i * k, j * k));
    }
    tileWidth = (width - (answersPerRow + 1.0) * spaceBetweenTiles) / answersPerRow;
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
    int answerIndex = rowIndex * answersPerRow + columnIndex;
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
      console("answer correct = " + answerCorrect + " isComplete = " + isComplete());
      if (answerCorrect) {
        console("answer correct !");
        if (isComplete()) {
          console("practice complete !");
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
    textSize( (int) (headerAndFooterHeight  * 0.8));
    String question = getQuestion();
    text(question, (width - textWidth(question))/2, headerAndFooterHeight * 0.9);

    //draw grid and numbers
    textSize( (int) (headerAndFooterHeight  * 0.8));
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
      //float textWidth_ = textWidth(answer);
      String answerStr = "" + answer;
      text(answerStr, upperLeftX + (tileWidth - textWidth(answerStr)) / 2, -7+ upperLeftY +  (tileWidth + textSize_) / 2);

      ++columnIndex;
      if (columnIndex >= answersPerRow) {
        columnIndex = 0;
        ++rowIndex;
      }
    }
  }

  void restart() {
    model = new Model();
    answersPerRow = 4;
    while (model.getQuestionCount () < answersPerRow * answersPerRow) {
      //      QuestionWithAnswer qa = currentController.generateQuestion();
      model.addQuestionWithAnswer(generateQuestion());
    }
    tileWidth = (width - (answersPerRow + 1.0) * spaceBetweenTiles) / answersPerRow;
    distanceBetweenAnswers = tileWidth + spaceBetweenTiles;
    return;
  }
}

// **** AdditionController ********
class AdditionController extends IntegerGameController {

  String name() {
    return "addition";
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
    int answerIndex = rowIndex * answersPerRow + columnIndex;
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
      console("answer correct = " + answerCorrect + " isComplete = " + isComplete());
      if (answerCorrect) {
        console("answer correct !");
        if (isComplete()) {
          console("practice complete !");
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
    textSize( (int) (headerAndFooterHeight  * 0.8));
    String question = getQuestion();
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
      int textSize_ = (int) (tileWidth * 0.5);
      textSize(textSize_);
      float textWidth_ = textWidth(answer);
      float maxWidthFraction = 0.8;
      if (textWidth_ > tileWidth * maxWidthFraction) {
        textSize_ = (int) (textSize_ * tileWidth * maxWidthFraction / textWidth_);
        textSize(textSize_);
        textWidth_ = textWidth(answer);
      };
      text(answer, upperLeftX + (tileWidth - textWidth(answer)) / 2, -7+ upperLeftY +  (tileWidth + textSize_) / 2);

      ++columnIndex;
      if (columnIndex >= answersPerRow) {
        columnIndex = 0;
        ++rowIndex;
      }
    }
  }

  void restart() {
    model = new StringAnswerModel();
    answersPerRow = 4;
    while (model.getQuestionCount () < answersPerRow * answersPerRow) {
      //      QuestionWithAnswer qa = currentController.generateQuestion();
      model.addQuestionWithAnswer(generateQuestion());
    }
    tileWidth = (width - (answersPerRow + 1.0) * spaceBetweenTiles) / answersPerRow;
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
class TraceBall {
  float x, y, easing;

  TraceBall(float easing_) {
    x = width/2;
    y = height/2;
    easing = easing_;
  }

  void drawBall() {
    pushMatrix();
    noStroke();
    x += (mouseX - x) * easing;    
    y += (mouseY - y) * easing;
    float radius = easing * 20.0;
    ellipse(x, y, radius, radius);
    popMatrix();
  }
}


