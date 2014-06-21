class Vertex {
  float x, y, z;
  //
  //  Vertex(float x_, float y_, float z_) {
  //    x = x_;
  //    y = y_;
  //    z = z_;
  //  }

  Vertex() {
    do {
      x = random(-width, width); 
      y = random(-width, width); 
      z = random(-width, width);
    }  
    while (length () > width);
    normalize();
  }

  void draw() {
//    pushMatrix();
//    translate(x , y , z);
    //    println(""+x+","+y+","+z);
    stroke(255,0,0);
    fill(255, 0, 0);
    //sphere(5);
    point(x,y,z);
//    popMatrix();
  }

  float length() {
    return dist(0, 0, 0, x, y, z);
  }

  void normalize() {
    float d = 0.3 * width / length();
    x *= d;
    y *= d;
    z *= d;
  }
}
