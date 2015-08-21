/*
to do:
 - add replay button
 */

Model model;
boolean redraw = true;
float spaceBetweenTiles = 10.0;
float headerAndFooterHeight = 50;
float tileWidth;
float distanceBetweenAnswers;
int answersPerRow;
long startTime;
int maxMultiplicand = 9;
//RestartButton restartButton = new RestartButton(headerAndFooterHeight * 0.4);

void setup() {
  //  int w = 480;
  //  int h = w + headerAndFooterHeight * 2;
  size(480, 580);
  reset();
}

void reset() {
  model = new Model();
  for (int n = 2; n <= 9; ++i)
    for (int d = 2; d <= 9; ++j) 
      for (int multiple = 2; d <= 9; ++m) {
        if ( i != 0 && j != 0) {
          String q = n * multiple + "/" + d * multiple + "=";
          String a = n  + "/" + d  ;
          model.addQuestionWithAnswer(q, a);
        }
      }

  answersPerRow = 5;
  model.reduceSizeTo(answersPerRow * answersPerRow);
  tileWidth = (width - (answersPerRow + 1.0) * spaceBetweenTiles) / answersPerRow;
  distanceBetweenAnswers = tileWidth + spaceBetweenTiles;
  startTime = millis();
}

void draw() {
  if (!redraw) return;
  redraw = false;
  background(200);
  int textSize_ = (int) (headerAndFooterHeight * 0.4);
  setTextSize(textSize_);
  fill(0);
  //  rect(10,10,10,10);

  //show time
  long seconds =(millis()-startTime) * 0.001;
  //int seconds = 0;
  text("time: "+seconds, spaceBetweenTiles, height - spaceBetweenTiles);

  //show Restart button in center of bottom of screen
  //  restartButton.drawButton();

  //show score
  String scoreMsg = "missed: "+model.getMissCount();
  text(scoreMsg, (width  - textWidth(scoreMsg))/2, height - spaceBetweenTiles);
  scoreMsg = "remaining: "+model.getQuestionCount();
  text(scoreMsg, width  - textWidth(scoreMsg) - spaceBetweenTiles, height - spaceBetweenTiles);
  if (model.isComplete()) {
    //do victory dance
    String msg = model.isPerfect() ? "Perfect!" : "Done!";
    int msgHeight = width / msg.length() ;
    setTextSize(msgHeight);
    text(msg, (width - textWidth(msg)) /2, (height - msgHeight) / 2);
    return;
  }

  //show question
  setTextSize( (int) (headerAndFooterHeight  * 0.9));
  String question = model.getCurrentQuestion().getQuestion();
  text(question, (width - textWidth(question))/2, headerAndFooterHeight);

  //draw grid and numbers
  setTextSize( (int) (headerAndFooterHeight  * 0.8));
  int rowIndex = 0;
  int columnIndex = 0;
  for (int answer : model.getAnswers()) {
    //draw tile 
    stroke(100);
    strokeWeight(tileWidth/ 40);
    fill(255);
    float upperLeftX = spaceBetweenTiles + columnIndex * distanceBetweenAnswers;
    float upperLeftY = spaceBetweenTiles + rowIndex * distanceBetweenAnswers+ headerAndFooterHeight; 
    rect(upperLeftX, upperLeftY, tileWidth, tileWidth, tileWidth / 5);
    fill(0);

    //draw answer
    fill(100);
    textSize_ = (int) (tileWidth * 0.5);
    setTextSize(textSize_);
    //float textWidth_ = textWidth(answer);
    String answerStr = "" + answer;
    text(answerStr, upperLeftX + (tileWidth - textWidth(answerStr)) / 2, upperLeftY +  (tileWidth + textSize_) / 2);

    ++columnIndex;
    if (columnIndex >= answersPerRow) {
      columnIndex = 0;
      ++rowIndex;
    }
  }
}

void mouseReleased() {
  redraw = true;
  //  if(restartButton.mouseInButton()){
  if (model.isComplete()) {
    reset();
    return;
  }
  model.tryAnswer(answerClicked());
}

int answerClicked() {
  int columnIndex = (int) (mouseX / distanceBetweenAnswers);
  int rowIndex = (int) ((mouseY - headerAndFooterHeight) / distanceBetweenAnswers);
  int answerIndex = rowIndex * answersPerRow + columnIndex;
  if (answerIndex >= model.getAnswers().length)
    return 0;
  return model.getAnswer(answerIndex);
}

void setTextSize(int textSize_) {
  textSize(textSize_);
}

