
void setup() {
  size(480, 320);
//  background(255, 255, 160);
  background(#FFFFC0);
  
  //move (0,0) to the center of screen
  translate(width/2, height/2);
  int wHead = 220;//width of head
  int hHead = wHead * 2 / 3;//height of head
  int rHead = wHead / 5;//radius of head corners
  rect(-wHead/2,-hHead,wHead,hHead, rHead);
}
