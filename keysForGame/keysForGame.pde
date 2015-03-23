//based on http://www.openprocessing.org/sketch/100827

//bug: if shifting while typing, some keys may show as pressed
//when not pressed. 

String gameKeys = "asdf";
char[] gameCharsLowercase = gameKeys.toCharArray();
char[] gameCharsUppercase = gameKeys.toUpperCase().toCharArray();
boolean keysPressed[] = new boolean [gameKeys.length()];
int arrowKeyCodes[] = new int[] {
  UP, DOWN, LEFT, RIGHT
};
boolean arrowKeysPressed[] = new boolean [arrowKeyCodes.length];
float txtSize;

void setup() {
  size(400, 150);
  noStroke();
  smooth();
  textSize(width / 20);
}

void draw() {
  background(80);
  String display = "game keys: ";
  for (int i = 0; i < keysPressed.length; i++) {
    display += keysPressed[i] ? '1' : '0';
  }
  text(display, (width - textWidth(display))/2, height/2);

   display = "arrow keys UDLR: ";
  for (int i = 0; i < arrowKeysPressed.length; i++) {
    display += arrowKeysPrasdfasessed[i] ? '1' : '0';
  }
  text(display, (width - textWidth(display))/2, height * 0.75);
}

void keyPressed() {
  handleKeyEvent(true);
}

void keyReleased() {
  handleKeyEvent(false);
}

void handleKeyEvent(boolean isPressed) {
  if (key ==  CODED) {
    for (int i = 0; i < arrowKeyCodes.length; i++) {
      if (keyCode == arrowKeyCodes[i]) 
        arrowKeysPressed[i] = isPressed;
    }
  } else {
    //letters and numbers
    for (int i = 0; i < keysPressed.length; i++) {
      if (key == gameCharsLowercase[i] || key == gameCharsUppercase[i]) {
        keysPressed[i] = isPressed;
      }
    }
  }
}
