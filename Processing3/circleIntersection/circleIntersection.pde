void setup() {
  size(640, 480);

  background(255);
  translate(width/2, height/2);
  scale(1, -1);

//TODO: changing y-coordinate of c0 center broken
  Circle c0 = new Circle(70, 0, 80);
  Circle c1 = new Circle(80, 120, 120);

  c0.draw();
  c1.draw();
  
  Point[] intersections = c0.intersection(c1);
  for(Point point : intersections) {
    point.draw();
  }
}