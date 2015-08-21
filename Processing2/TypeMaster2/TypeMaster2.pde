String lastKeyPressed = "";
String targetString = "The quick brown fox.";
String enteredString = "";
int sizeOfText;
int baseTextColor = 0;
int errorTextBackground = color(255, 100, 100);
void setup() {
  size(640, 150);
  fill(baseTextColor);
  sizeOfText = height/4;
  textSize(sizeOfText);
}

void draw() {
  background(255);
  String txt = ""+lastKeyPressed;
  int xPos = sizeOfText/2;
  fill(baseTextColor);
  text(targetString, xPos, height / 3);
  //  println(""+keyCode+" "+((int)key));
  int yPos = 2 * height / 3;
  for (int i = 0; i < enteredString.length(); ++i) {
    char c = enteredString.charAt(i );
    char cTgt = targetString.charAt(i );
    float charWidth = textWidth(""+cTgt);
    if (cTgt!=c) {
      fill(errorTextBackground);
      noStroke();
      rect(xPos, yPos-sizeOfText, charWidth, sizeOfText);
    }
    fill(baseTextColor);
    text(""+c, xPos, yPos);
    xPos += charWidth;
  }
}

void keyPressed() {
  if (key == 8) {
    lastKeyPressed= "delete";
    int enteredStringLength = enteredString.length();
    if (enteredStringLength > 0)
      enteredString = enteredString.substring(0, enteredStringLength-1);
    return;
  } 
  if (key == 9) {
    lastKeyPressed= "tab";
    return;
  } 
  if (key <32) {
    lastKeyPressed= "key #"+((int) key);
    return;
  } 
  if (key != CODED) {
    lastKeyPressed = ""+key;
    enteredString += key;
  }
}
