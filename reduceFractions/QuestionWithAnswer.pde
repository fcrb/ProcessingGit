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

}

