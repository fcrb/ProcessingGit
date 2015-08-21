/* @pjs font="Monospaced-18.vlw"; */
// Features to add:
// - multiple phrases (from a data file?)
// - showing time
// - showing words completed.
// - score keeping
// 
String lastKeyPressed = "";
String targetString = "The quick brown fox jumps over a lazy dog.";
String enteredString = "";
float sizeOfText;
int baseTextColor = 0;
int errorTextBackground = color(255, 150, 150);
String[] chars;
void setup() {
  size(640, 150);
  background(255);
  // The font must be located in the 
  // current sketch's "data" directory to load successfully
  textFont(createFont("Monospaced", 18));
  fill(baseTextColor);
  text("Loading...", width * 0.3, height *0.6);

  sizeOfText = 18;
  textSize(sizeOfText);
  chars = new String[255];
  for (int i = 0; i < chars.length; ++i) {
    chars[i] = String.fromCharCode(i);
  }
}

void draw() {
  background(255);
  noStroke();
  float xPos = sizeOfText/2;
  text(targetString, xPos, height / 3);
  //  println(""+keyCode+" "+((int)key));
  int yPos = 2 * height / 3;
  for (int i = 0; i < enteredString.length(); ++i) {
    String c = enteredString.substring(i, i+1);
    String cTgt = targetString.substring(i, i+1);
    float charWidth = textWidth(cTgt) ;
    if (!cTgt.equals(c)) {
      fill(errorTextBackground);
      rect(xPos, yPos-sizeOfText, charWidth, sizeOfText);
    }
    fill(baseTextColor);
    text(c, xPos, yPos);
    xPos += charWidth;
  }
  if ( ((int)(frameCount/20))%2 == 0) {
    stroke(0);
    strokeWeight(textSize*0.2);
    line(xPos+2, yPos, xPos+2, yPos - sizeOfText);
  }
}

void keyPressed() {
  if (key == 8) {
    int enteredStringLength = enteredString.length();
    if (enteredStringLength > 0)
      enteredString = enteredString.substring(0, enteredStringLength-1);
    return;
  } 
  if (key <32) {
    return;
  } 
  if (key != CODED) {
    enteredString = enteredString + chars[key.code];
  }
}

