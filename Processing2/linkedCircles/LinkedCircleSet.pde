class LinkedCircleSet {
  ArrayList<Circle> circles = new ArrayList<Circle>();

  void addCircle(float x, float y, float radius) {
    circles.add(new Circle(x, y, radius));
  }

  void draw() {
    translate(width/2, height/2);

    //locate intersections
    for (int i = 1; i < circles.size(); ++i) {
      Circle ci = circles.get(i);
      for (int j = 0; j < i; ++j) {
        Circle cj = circles.get(j);
        ci.findIntersectionsWith(cj);
      }
    }

    for (Circle circle : circles) {
      circle.identifyIntersectionTypes();
    }

    for (Circle circle : circles) {
      circle.draw();
    }
  }
}
