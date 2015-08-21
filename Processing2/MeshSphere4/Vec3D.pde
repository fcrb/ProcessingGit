class Vec3D {
  float x, y, z;

  Vec3D(float x_, float y_, float z_) {
    x=x_;
    y=y_;
    z=z_;
  }

  //create random unit vector
  Vec3D() {
    do {
      x = random(-1, 1); 
      y = random(-1, 1); 
      z = random(-1, 1);
    }  
    while (length () > 1);
    normalize();
  }

  Vec3D copy() {
    return new Vec3D(x, y, z);
  }

  float distance(Vec3D v) {
    return dist(x, y, z, v.x, v.y, v.z);
  }

  float length() {
    return dist(0, 0, 0, x, y, z);
  }

  void add(Vec3D v) {
    x += v.x;
    y += v.y;
    z += v.z;
  }    

  void subtract(Vec3D v) {
    x -= v.x;
    y -= v.y;
    z -= v.z;
  }    

  void normalize() {
    scaleBy(1/length());
  }

  void scaleBy(float s) {
    x *= s;
    y *= s;
    z *= s;
  }

  String displayString() {
    return "len("+x+","+y+","+z+")="+length();
  }
}
