class Sphere implements Visible {
  float x, y, z, diameter;
  int clr;
  float angle = 0;
  
  Sphere(float x_, float y_, float z_, float d, int clr_) {
    x = x_;
    y = y_;
    z = z_; 
    diameter = d;
    clr = clr_;
  }

  void draw() {
    pushMatrix();
    fill(clr);
    rotateY(angle);
    angle += 0.01;
    translate(x, y, z);
    noStroke();
    sphere(diameter);
    popMatrix();
  }
  
}
