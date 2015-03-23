//based on http://www.openprocessing.org/sketch/100827

//bug: if shifting while typing, some keys may show as pressed
//when not pressed. 

boolean keyz[] = new boolean [256];

void setup() {
  size(400, 150);
  noStroke();
  smooth();
  textSize(width / 10);
}

void draw() {
  background(80);
  String keysPressed = "";
  for (int i = 0; i < keyz.length; i++) {
    if (keyz[i]) {
      keysPressed += char(i);
    }
  }

  text(keysPressed, (width - textWidth(keysPressed))/2, height/2);
}

void keyPressed() {
  if (key < keyz.length) {
    keyz[key] = true;
  }
}

void keyReleased() {
  if (key < keyz.length) {
    keyz[key] = false;
  }
}
