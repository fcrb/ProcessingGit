abstract class GameController { //<>//
  int answersPerRow() {
    return 4;
  }
  abstract void drawView();
  abstract float elapsedTime();  
  abstract int getMissCount();  
  abstract int getQuestionCount();  
  abstract void handleMouseRelease();
  abstract boolean isComplete();
  abstract boolean isPerfect();
  abstract String name();

  void recordScore() {
    if (userName().equals("")) return;
    String putScoreURL = "record_score.php?";
    putScoreURL += "practice="+name();
    putScoreURL += "&score="+getMissCount();
    putScoreURL += "&time="+elapsedTime();
    printConsole(putScoreURL);
    //text(putScoreURL, 20, 40);
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
    printConsole("scoreReport");
    //if (userName().equals("")) return;

    String[] rows;
    if (!inJavascriptMode())
      rows = loadStrings("get_tabbed_scores.html");
    else
      rows = loadStrings("get_tabbed_scores.php");
    printConsole("scoreReport: row count = " + rows.length);
    ArrayList<PracticeReport> practiceReports = new ArrayList<PracticeReport>();
    String previousPractice = "garbageRatherThanNullToAccommodateProcessingjs";
    PracticeReport report = null;
    for (int i = 1 ; i < rows.length; ++i) {
      String[] fields = rows[i].split("\t");
      //      //{"practice":"addition", "score":"1", "duration":"25.582000732422", "date":"2013-11-19", "time":"00:04:22"},
      String practice = fields[0];
      int score = int(fields[1]);
      float duration = float(fields[2]);
      printConsole("scoreReport: row " +i +": "+ practice +" "+score + " "+duration);
      if (!practice.equals(previousPractice)) {
        report = new PracticeReport(practice);
        practiceReports.add(report);
        previousPractice = practice;
      }
      report.addScore(score, duration);
    }
    int rowY = height / 5;
    int rowHeight = 20;
    int xStart = 20;
    int   xLeft = xStart;
    int[] columnWidths = {
      120, 50, 70, 70
    };
    rowY +=rowHeight;
    xLeft += columnWidths[0];
    text("  #", xLeft, rowY-15);
    text("games", xLeft, rowY);
    xLeft += columnWidths[1];
    text("best", xLeft+18, rowY-15);
    text("time", xLeft+18, rowY);
    xLeft += columnWidths[2];
    text(" top ten", xLeft, rowY-15);
    text("avg time", xLeft, rowY);
    xLeft += columnWidths[3];
    text(" top ten", xLeft, rowY-15);
    text("avg score", xLeft, rowY);
    fill(100);
    for (PracticeReport rep : practiceReports) {
      xLeft = xStart;
      line(xLeft, rowY+5, width - xLeft, rowY + 5);
      rowY += rowHeight;
      text(rep.getFluencyName(), xLeft, rowY );
      xLeft += columnWidths[0];
      text(intPadded(rep.numberGames, 4), xLeft, rowY );
      xLeft += columnWidths[1];
      text(roundFloatPadded(rep.fastestTime, 2, 9), xLeft, rowY );
      xLeft += columnWidths[2];
      text(roundFloatPadded(rep.totalTime/rep.numberGamesToAverage, 1, 9), xLeft, rowY );
      xLeft += columnWidths[3];
      text(roundFloatPadded(((float)rep.totalScore)/rep.numberGamesToAverage, 1, 9), xLeft, rowY );
    }
  }    

  abstract void restart();
}

class PracticeReport {
  String name;
  int numberGames = 0;
  int numberGamesToAverage = 0;
  float totalTime = 0;
  int totalScore = 0;
  int MAX_SCORES = 10;
  float fastestTime = 1.0e9;//POSITIVE_INFINITY was a bad idea (Processing.js)
  int MAX_SCORE_FOR_FASTEST_TIME = 3;
  String[] nameCodes = {
    "addition", "add_pos_digits", "binary", "factoring", "gcf", "lcm", "log10", "modulus", "modulus_9", 
    "multiplication", "multiply_negatives", "reduce_fractions", "squares", "subtract_positive", 
    "two_digit_addition"
  };
  String[] nameLabels = {
    "Add/Subtract", "Add positives", "Binary", "Factoring", "GCF", "LCM", "Logarithm", "Modulus", "Modulo 9", 
    "Multiplication", "Multiply negatives", "Reduce fractions", "Perfect squares", "Subtract positives", 
    "Two digit addition"
  };

  public PracticeReport(String name_) {
    name = name_;
  }

  void addScore(int score, float duration) {
    ++numberGames;
    if (duration < fastestTime && score <= MAX_SCORE_FOR_FASTEST_TIME)
      fastestTime = duration;
    if (numberGames > MAX_SCORES) {
      return;
    }
    ++numberGamesToAverage;
    totalScore += score;
    totalTime += duration;
  }

  String getFluencyName() {
    for (int i = 0; i < nameCodes.length; ++i) {
      if (name.equals(nameCodes[i])) return nameLabels[i];
    }
    return name;
  }
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
  boolean scoresShown = false;
  void drawView() {
    if(scoresShown) return;
    background(255);
    fill(0);
    scoreReport();
    scoresShown = true;
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
    scoresShown = false;
  }
}
