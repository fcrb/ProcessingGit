class Model {
  ArrayList<QuestionWithAnswer> questionsWithAnswers= new ArrayList<QuestionWithAnswer>(0);
  int[] sortedAnswers;
  QuestionWithAnswer currentQuestionWithAnswer;
  int score = 0;
  int missCount = 0;

  void addQuestionWithAnswer(String q, int a) {
    questionsWithAnswers.add(new QuestionWithAnswer(q, a));
    sortedAnswers = null;
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

  int getAnswer(int index) {
    return getAnswers()[index];
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


  void tryAnswer(int answer) {
    if (answer == 0)
      return;
    if (answer == getCurrentQuestion().getAnswer()) {
      sortedAnswers = null;
      questionsWithAnswers.remove(currentQuestionWithAnswer);
      currentQuestionWithAnswer = null;
    }
    else {
      ++missCount;
    }
  }
}

