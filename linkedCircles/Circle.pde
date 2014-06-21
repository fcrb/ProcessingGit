class Circle {
  float x, y, r;
  ArrayList<Intersection> intersections = new ArrayList<Intersection>();

  Circle(float x_, float y_, float r_) {
    x = x_; 
    y = y_; 
    r = r_;
  }

  void draw() {
    noFill();
    float r_outer = r *1.1;
    ellipse(x, y, outerRadius() * 2, outerRadius() * 2);
    float r_inner = r * 0.9;
    ellipse(x, y, r_inner * 2, r_inner * 2);

    for (Intersection intersection: intersections)  {  
      intersection.draw();
    }

    //    Intersection previousIntersection = intersections.get(intersections.size() - 1);
    //    for ( int i = 0;   i < intersections.size();   ++i) {
    //      Intersection intersection = intersections.get(i);
    //      float angleThisOuterWithInner = angleFromCenter(x, y, 
    //      arc(x, y, outerRadius() * 2, outerRadius() * 2,
    //    }
  }

  float innerRadius() {
    return r * 0.9;
  }

  float outerRadius() {
    return r * 1.1;
  }

  void orderIntersectionsByAngle() {

    ArrayList<Intersection> orderedIntersections = new ArrayList<Intersection>();
    float lastAngleOrdered = -1;
    while (orderedIntersections.size () < intersections.size()) {
      int index = -1;
      float smallestUnorderedAngle = 3*PI;
      for (int i = 0; i < intersections.size(); ++i) {
        Intersection intersection = intersections.get(i);
        float angle = intersection.angleFromCenter(this);
        if (angle > lastAngleOrdered) {
          if (angle < smallestUnorderedAngle) {
            index = i;
            smallestUnorderedAngle = angle;
          }
        }
      }
      orderedIntersections.add(intersections.get(index));
      lastAngleOrdered = smallestUnorderedAngle;
    }
    intersections = orderedIntersections;
  }

  void identifyIntersectionTypes() {
    orderIntersectionsByAngle();
    Intersection previousIntersection = null;
    int indexPrevious = 0;
    for (Intersection intersection : intersections) {
      if (intersection.hasTopCircle()) {
        previousIntersection = intersection;
        break;
      }
      ++indexPrevious;
    }
    if (previousIntersection == null) {
      indexPrevious = 0;
      previousIntersection = intersections.get(0);
      previousIntersection.setTopCircle(this, true);
    } 
    boolean previousWasTop = previousIntersection.topCircle == this;

    for (int j = 0; j < intersections.size(); ++j) {
      indexPrevious = (indexPrevious + 1) % intersections.size();
      Intersection intersection = intersections.get(indexPrevious);
      intersection.setTopCircle(this, !previousWasTop);
      previousWasTop = !previousWasTop;
    }
  }

  void findIntersectionsWith(Circle otherCircle) {
    PairOfPoints points = circleIntersections(x, y, r, otherCircle.x, otherCircle.y, otherCircle.r);
    if (points == null) return;
    Intersection intersection = new Intersection(points.x1, points.y1, this, otherCircle);
    intersections.add(intersection);
    otherCircle.intersections.add(intersection);
    intersection = new Intersection(points.x2, points.y2, this, otherCircle);
    intersections.add(intersection);
    otherCircle.intersections.add(intersection);
  }
}

float angleInRadians(float x_ctr, float y_ctr, float x, float y) {
  float angle = atan( (y - y_ctr) / (x - x_ctr) );
  boolean inQuadrantIorIV = (x > x_ctr);
  if  ( !inQuadrantIorIV ) {
    angle += PI;
  }
  if (angle < 0 ) angle += 2 * PI;
  return angle;
}


PairOfPoints circleIntersections(float x1, float y1, float r1, float x2, float y2, float r2) {
  if (dist(x1, y1, x2, y2) >= r1 + r2) {
    return null;
  }
  float k1 = 2 * (x2 - x1);
  float k2 = 2 * (y2 - y1);
  float k3 = r2*r2 - r1 * r1 - x2*x2 + x1*x1 - y2*y2 + y1 * y1;
  float x_1, y_1, x_2, y_2;
  if (k1 == 0) {
    //vertically aligned
    y_1 = y_2 = -k3/k2;
    float absxMinusx1 = sqrt(r1*r1 - (y_1-y1)*(y_1-y1));
    x_1 = x1 + absxMinusx1;
    x_2 = x1 - absxMinusx1;
  } 
  else {
    //not vertically aligned
    float a = 1 + k2 * k2 / (k1*k1);
    float b = 2 * ((k3/k1+x1)*k2/k1 - y1);
    float c = (k3/k1+x1)*(k3/k1+x1) + y1*y1 -r1*r1;
    float d = sqrt(b*b-4*a*c);
    y_1 = (-b - d)/(2*a);
    x_1 = - k2 / k1 * y_1 - k3 / k1;
    y_2 = (-b + d)/(2*a);
    x_2 = - k2 / k1 * y_2 - k3 / k1;
  }
  return new PairOfPoints(x_1, y_1, x_2, y_2);
}
