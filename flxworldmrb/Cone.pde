class Cone implements Visible {
  float x, y, z, radius, coneHeight;
  int numSides, clr;
  float angle = 0;
  boolean includeBottom;

  Cone(float x_, float y_, float z_, int sides, float r, float h, boolean includeBottom_, int clr_) {
    x = x_;
    y = y_;
    z = z_; 
    numSides = sides;
    radius = r;
    coneHeight = h;
    includeBottom = includeBottom_;
    clr = clr_;
  }

  void draw()
  {
    pushMatrix();
    translate(x, y, z);
    rotateX(-PI/2);
    fill(clr);
    float angle = 2 * PI / numSides;
    float halfHeight = coneHeight / 2;
    noStroke();

    if (includeBottom) {// draw bottom of the tube
      beginShape();
      for (int i = 0; i < numSides; i++) {
        float x_ = cos(i * angle) * radius;
        float y_ = sin(i * angle) * radius;
        vertex(x_, y_, halfHeight);
      }
      endShape(CLOSE);
    }

    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i <= numSides ; i++) {
      float x = cos(i * angle) * radius;
      float y = sin(i * angle) * radius;
      vertex(x, y, halfHeight);
      vertex(0, 0, -halfHeight);
    }
    endShape(CLOSE);
    popMatrix();
  }
}

