float diameter = 40;
float circleSeparation = 50;


void setup() {
  size(640,160);
  noStroke();
  frameRate(60);
}

void draw() {
  background(0);
  
  ellipse(frameCount*2, height/2, diameter, diameter);
  for(int i = 1; i < ((int) frameCount / circleSeparation);++i) {
      ellipse( i * circleSeparation * 2, height/2, diameter, diameter);
  }

}
