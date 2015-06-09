/*
Car with sensors. Objective is to stay on track.
Orientation is with origin at center of screen, and y increases
as you move up the screen.
*/
Car car;
Track track;

void setup() {
  size(640, 480);
  track = new Track();
  car = new Car();
}

void draw() {
  background(0, 127, 0);
  translate(width/2, height/2);
  scale(1, -1);

  track.draw();
  car.draw();
  car.accelerate();
}

