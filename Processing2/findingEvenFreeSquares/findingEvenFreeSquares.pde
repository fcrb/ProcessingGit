void setup() {
  size(200,200);
  
  char[] evenDigits = new char[] {
    '0', '2', '4', '6', '8'
  };
  
  for (int i = 11; i < 10000; i += 2) {
    boolean containsEven = false;
    String digits = "" + (i*i);
    for (char e : evenDigits) {
      if (digits.indexOf(e ) >= 0) {
        containsEven = true;
      }
    }
    if (!containsEven) {
      println(""+i+"^2=" + i*i);
    }
  }
  println("done");
}
