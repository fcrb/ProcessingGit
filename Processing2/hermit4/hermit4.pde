void setup() {
  size(480, 480);
  hermits = new ArrayList<Hermit>();
  int numberOfHermits = 30;
  for(int i = 0; i < numberOfHermits; ++i) {
  hermits.add(new Hermit());
  }
}

class Hermit {
  float x = random(width), y = random(height);
  float diameter = width/20;
  float mass = 1;
  color c = color(255, 0, 0);
  boolean drag = false;

  void dragIfSelected() {
    drag  = (dist(x, y, mouseX, mouseY)<diameter);
    if (drag) {
      dragHermit = this;
    }
  }

  void drawIt() {
    fill(c);
    noStroke();
    if (dragHermit == null)
      c = color(255, 0, 0);
    else 
      c = color(255, max(0, 255-dist(x, y, dragHermit.x, dragHermit.y)), 0);
    ellipse(x, y, diameter, diameter);
  }

  Hermit move() {
    if (drag) {
      x = mouseX;
      y = mouseY;
    } 
    else {
      float f_x=0, f_y=0;
      for (Hermit hermit : hermits) {
        if (hermit != this) {
          float d2 = dist(x, y, hermit.x, hermit.y);
          d2 *= d2;
          if (d2 < 1) {
            //too close -- bump apart
            d2 = 1; 
            x += random(4) - 2; 
            y += random(4) - 2;
          }
          f_x += (x - hermit.x) / d2 / d2; 
          f_y += (y - hermit.y) / d2/ d2  ;
        }
      }
      float forceMultiplier = 500000;
      x += f_x * forceMultiplier;
      y += f_y * forceMultiplier;
      //moveToEdgeOfWindow();
      moveToEdgeOfCircle();
    }
    return this;
  }

  void moveToEdgeOfCircle() {
    float d = dist(x, y, width/2, height/2);
    float x_mid = width * 0.5;
    float maxD = x_mid * 0.9;
    if(d > maxD ) {
      x = x_mid + (x - x_mid) * maxD/ d ;
      y = height /2 + (y - height/2) * maxD / d;
    }
  }

  void moveToEdgeOfWindow() {
    float radius = diameter * 0.5;
    x=max(x, radius);
    x=min(x, width - radius);
    y=max(y, radius);
    y=min(y, height - radius);
  }

  void releaseDrag() {
    drag = false;
    dragHermit = null;
  }
}

ArrayList<Hermit> hermits;
Hermit dragHermit;
color bgColor = color(0);

void draw() {
  background(bgColor);
  for(Hermit hermit : hermits) {
    hermit.move().drawIt();
  }
}

void mousePressed() {
  for(Hermit hermit : hermits) {
    hermit.dragIfSelected();
  }
}  

void mouseReleased() {
  for(Hermit hermit : hermits) {
    hermit.releaseDrag();
  }
}  




