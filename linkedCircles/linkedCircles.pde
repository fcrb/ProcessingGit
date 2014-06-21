LinkedCircleSet circles = new LinkedCircleSet();

void setup () {
  size(320, 320);

  float shift = width / 8;
  float radius = width / 5;
  circles.addCircle(-shift, 0, radius);
  circles.addCircle(shift, 0, radius);
  circles.addCircle(shift, -shift*2, radius);
  
  circles.draw();
}
