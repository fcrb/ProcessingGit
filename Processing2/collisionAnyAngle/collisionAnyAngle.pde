CarSystem carSystem;
float carScale = 0.2;
color bgColor = color(255);
color txtColor = color(0, 0, 100);
boolean fade = false;
float elapsedTimeToLastClockStopInMillis;
boolean clockRunning = false;
float timeClockStarted;
float secondsFromStartToCollision = 5;
String debug = "";

void setup() {
  size(480, 360);
  background(bgColor);
  resetClock();
  carSystem = new CarSystem();
  noStroke();
}

void resetClock() {
  timeClockStarted = (float) millis();
  elapsedTimeToLastClockStopInMillis = 0;
}

void draw() {
  smooth();
  if (fade) {
    fill(bgColor, 15);
    rect(0, 0, width, height);
  } 
  else {
    background(bgColor);
  }
  String timeMessage = "time: " + formatFloat(0.001 * elapsedTimeInMillis(), 2)+"s";
  drawString(timeMessage, 18, 0, width/20, width/20);
  carSystem.drawIt();
}

void drawString(String s, int tSize, color c, float x, float y) {
  textSize(tSize);
  float tw = textWidth(s);
  //  fill(bgColor);
  //  rect(x, y-tSize, tw, tSize * 6);
  //  fill(c);
  text(s, x, y);
}

void run(boolean runClock) {
  if (clockRunning) {
    //clock is being stopped
    elapsedTimeToLastClockStopInMillis = elapsedTimeInMillis();
  } 
  else {
    //clock is being started
    timeClockStarted = millis();
  }
  clockRunning = !clockRunning;
}

float elapsedTimeInMillis() {
  return elapsedTimeToLastClockStopInMillis + (clockRunning ? millis() - timeClockStarted : 0);
}

String formatFloat(float x, int numPlaces) {
  int power = 1;
  for (int i = 0; i < numPlaces; ++i)
    power *= 10;
  int expanded = (int) (x * power + 0.5);
  int whole = (int) (expanded / power);
  String frac = ""+ (expanded % power);
  while (frac.length () < numPlaces)
    frac = "0"+frac;
  return ""+whole+"."+frac;
}

// Called from javascript in the browser.
void setHeading(int carNumber, float m) {
  carSystem.setHeading(carNumber, m);
}

// Called from javascript in the browser.
void setMass(int carNumber, float m) {
  carSystem.setMass(carNumber, m);
}

// Called from javascript in the browser.
void setSpeed(int carNumber, float s) {
  carSystem.setSpeed(carNumber, s);
}

class Car {
  TwoDVector position;
  ArrayList<TwoDVector> pastPositions;
  TwoDVector v_0;
  TwoDVector velocity;
  float mass_ = 1000;
  color c;
  boolean drag = false;
  float timeOfLastMove = 0;
  boolean isOnLeft = false;

  Car(TwoDVector v, color c_) {
    v_0 = v;
    c = c_;
    reset();
  }

  void reset() {
    velocity = v_0;
    position = new TwoDVector(width/2, height/2);
    position = position.plus(velocity.scaleBy(-secondsFromStartToCollision));
    pastPositions = new ArrayList<TwoDVector>();
  }

  float diameter() {
    return 10 * carScale * pow(mass_, 1.0/3);
  }

  float distance(Car c) {
    return dist(position.x, position.y, c.position.x, c.position.y);
  }

  boolean touching(Car c) {
    return position.distance(c.position) < (diameter() + c.diameter()) * 0.5;
  }

  void drawIt() {
    int maxNumberPastPositions = 20;
    float d = diameter();
    while (pastPositions.size () >= maxNumberPastPositions) {
      pastPositions.remove(0);
    }
    float i = 1;
    for (TwoDVector pastPosition : pastPositions) {
      fill(c, 20.0 *  i / pastPositions.size());
      ellipse(pastPosition.x, pastPosition.y, d, d);
      ++i;
    }
    fill(c);
    ellipse(position.x, position.y, d, d);
    if (pastPositions.isEmpty() || position.distance(pastPositions.get(pastPositions.size() - 1)) > d*0.25) {
      pastPositions.add(position);
    }

    String description = "mass="+mass_+" kg"  
      +"\nspeed="+ formatFloat(velocity.len(), 3) + " m/s"
      +"\nheading="+formatFloat(velocity.hdg(), 2) + "\u00b0"
    +"\nposition="+position.display() +" ";
    int fontSize = 16;
    if (isOnLeft) {
      drawString( description, fontSize, c, width * 0.05, height * 0.20);
    } 
    else {
      drawString( description, fontSize, c, width * 0.6, height  * 0.6);
    }
  }

  float angle() {
    if (velocity.x == 0) {
      return 0.5 * (( velocity.y < 0 )? PI : -PI);
    }
    return atan( - velocity.y / velocity.x  ) + ((velocity.x < 0) ?  PI : 0);
  }

  void setIsOnLeft(boolean is_) {
    isOnLeft = is_;
  }

  TwoDVector momentum() {
    return velocity.scaleBy(mass_);
  }

  Car move() {
    float t = elapsedTimeInMillis() * 0.001;
    float dt = t - timeOfLastMove;
    position = position.plus(velocity.scaleBy(dt));
    timeOfLastMove = t;
    return this;
  }

  Car setSpeed(float s) {
    float minSpeed = 1.0e-9;
    if( s < minSpeed)
      s = minSpeed;
    v_0 = v_0.unit().scaleBy(s);
    return this;
  }

  Car setHeading(float headingInDegrees) {
    float spd = v_0.len();
    float a = PI * 0.5 - (headingInDegrees * PI / 180);
    v_0 = new TwoDVector(spd * cos(a), -spd * sin(a));
    return this;
  }

  Car setMass(float m_) {
    mass_ = m_;
    return this;
  }

  Car setPostCollisionVelocity(TwoDVector v) {
    velocity = v;
    return this;
  }
}

class CarSystem {
  ArrayList<Car> cars;
  boolean collided = false;

  CarSystem() {
    cars = new ArrayList<Car>();

    Car car = new Car(new TwoDVector(20, 0), color(255, 0, 0));
    cars.add(car);
    car.setIsOnLeft(true);

    car = new Car(new TwoDVector(0, -20), color(0, 0, 255));
    cars.add(car);
  }

  void drawIt() {
    Car car0 = cars.get(0);
    Car car1 = cars.get(1);
    if (car0.mass_ > car1.mass_) {
      car0.move().drawIt();
      car1.move().drawIt();
    } 
    else {
      car1.move().drawIt();
      car0.move().drawIt();
    }
    if (car0.touching(car1)) {
      TwoDVector momentum = car0.momentum();
      momentum = momentum.plus(car1.momentum());

      //Argg! Multiplying by 1.0 is a hack to get
      //processing.js to treat the masses as numbers 
      //rather than strings.
      float scaleFactor = 1.0/(car0.mass_ +  1.0 * car1.mass_);
      TwoDVector v = momentum.scaleBy(scaleFactor);
      car0.setPostCollisionVelocity(v);
      car1.setPostCollisionVelocity(v);
    }
  }

  void resetCars() {
    resetClock();
    for (Car car: cars)
      car.reset();
    background(bgColor);
  }    

  void setHeading(int carNumber, float h) {
    cars.get(carNumber).setHeading(h);
    resetCars();
  }

  void setMass(int carNumber, float m) {
    cars.get(carNumber).setMass(m);
    resetCars();
  }

  void setSpeed(int carNumber, float s) {
    cars.get(carNumber).setSpeed(s);
    resetCars();
  }
}

float hdgFromAngle(float a) {
  float h = 90.0 - a * 180.0/PI ;
  while (h <= 0) h += 360;
  while (h > 360) h -= 360;
  return h;
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
    return hdgFromAngle(angle());
  }

  TwoDVector scaleBy(float s) {
    return new TwoDVector(x * s, y * s);
  }

  TwoDVector plus(TwoDVector v) {
    return new TwoDVector(x + v.x, y + v.y);
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
