/* @pjs font="Courier-24.vlw"; */
String lastKeyPressed = "";
String targetString = "The quick brown fox jumps over a lazy dog.";
String enteredString = "";
int sizeOfText;
int baseTextColor = 0;
int errorTextBackground = color(255, 100, 100);
String[] chars;
void setup() {
  size(640, 150);
  // The font must be located in the 
  // current sketch's "data" directory to load successfully
  textFont(createFont("Courier", 24));
  fill(baseTextColor);
  sizeOfText = 24;
  textSize(sizeOfText);
  chars = new String[255];
  for (int i = 0; i < chars.length; ++i) {
    chars[i] = String.fromCharCode(i);
//    console.log(i, chars[i]);
  }
  println("setup complete");
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
    xPos += charWidth + 0.4;
  }
  if( ((int)(frameCount/20))%2 == 0) {
    stroke(0);
    strokeWeight(textSize*0.2);
    line(xPos+2, yPos, xPos+2, yPos - sizeOfText);
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
//    console.log(key);
//    console.log(key.code);
//    console.log(chars[key.code]);
    enteredString = enteredString + chars[key.code];
//    console.log(enteredString);
  }
}

