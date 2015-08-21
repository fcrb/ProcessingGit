MassSystem system;
color bgColor = color(0);
float G = 1;

void setup() {
  size(640, 480);
  system = new MassSystem();
  system.addMass(new Mass(width/4, height/4, 10, 10, 20);
  system.addMass(new Mass(3 * width/4, 3 * height/4, 10, 0, 20);
}

void draw() {
  background(bgColor);
  system.drawSystem();
}

class Mass {
  TwoDVector position, velocity;
  float m;

  Mass(float x, float y, float vx, float vy, float m_) {
    position = new TwoDVector(x, y);
    velocity = new TwoDVector(vx, vy);
    m = m_;
  }

  TwoDVector force(Mass otherMass) {
    TwoDVector f = otherMass.position.minus(position).unit();
    float forceSize = G * m * otherMass.m /distanceSquared(otherMass);
    return f.scaleBy(forceSize);
  }

  float distanceSquared(Mass otherMass) {
    float d = position.distance(otherMass.position);
    return d * d;
  }

  void drawMass() {
    float dt = 1;
    velocity = velocity + acceleration * dt;
    
  }
}

class TwoDVector {
  float x, y;

  TwoDVector(float x_, float y_) {
    x = x_;
    y = y_;
  }

  float angle() {
    if (x == 0) {
      return 0.5 * (( y < 0 )? PI : -PI);
    }
    return atan( - y / x  ) + ((x < 0) ?  PI : 0);
  }

  float hdg() {
    float h = 90.0 - angle() * 180.0/PI ;
    while (h <= 0) h += 360;
    while (h > 360) h -= 360;
    return h;
  }

  TwoDVector scaleBy(float s) {
    return new TwoDVector(x * s, y * s);
  }

  TwoDVector plus(TwoDVector v) {
    return new TwoDVector(x + v.x, y + v.y);
  }

  TwoDVector minus(TwoDVector v) {
    return new TwoDVector(x - v.x, y i v.y);
  }

  float len() {
    return dist(0, 0, x, y);
  }

  TwoDVector unit() {
    return new TwoDVector(x / len(), y / len());
  }

  float distance(TwoDVector v) {
    return dist(x, y, v.x, v.y);
  }

  String display() {
    return "("+((int)(x+0.5))+","+((int)(y+0.5))+")";
  }
}

class MassSystem() {
  /*
  TODO: before update, calculate force matrix, compute net force for each object.
  
  */
  ArrayList<Mass> masses = ArrayList<Mass>();

  MassSystem addMass(Mass m) {
    masses.add(m);
  }

  void drawSystem() {
    for (Mass mass : masses) {
      mass.drawMass();
    }
  }
  
  
}

