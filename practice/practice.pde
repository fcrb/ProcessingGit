void setup() {
  size(320,240);
//  rect(20,40,250,50);
 // arc(width/2, height/2, width, height, 0, 1.57);
 frameRate(60);
 smooth();
}

void draw() {
  float angle = frameCount *0.05;
  if(angle < 2 * Math.PI)
    arc(width/2, height/2, width, height, 0, angle);
}
