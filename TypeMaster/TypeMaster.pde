String lastKeyPressed = "";
String enteredString = "";
int sizeOfText;
void setup() {
  size(240, 135);
  fill(0);
  sizeOfText = height/2;
  textSize(sizeOfText);
}

void draw() {
  background(255);
  String txt = ""+lastKeyPressed;
  translate(width/2- textWidth(txt)/2, height/2+ sizeOfText/3);
  text(txt, 0, 0);
  println(""+keyCode+" "+((int)key));
}

void keyPressed() {
  if (key == 8) {
    lastKeyPressed= "delete";
    return;
  } 
  if (key == 9) {
    lastKeyPressed= "tab";
    return;
  } 
  if (key <32) {
    lastKeyPressed= ""+((int) key);
    return;
  } 
  if (key != CODED) {
    lastKeyPressed = ""+key;
    return;
  }
}
