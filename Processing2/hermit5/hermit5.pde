ArrayList<Hermit> hermits;
Hermit dragHermit;
float hermitDiameter = 20;
color bgColor = color(0);

void setup() {
  size(480, 480);
  hermits = new ArrayList<Hermit>();
  setNumHermits(30);
  background(bgColor);
}

// This is not called from the sketch! it is called
// by javascript in the browser.
void setNumHermits(int n) {
  while (hermits.size () > n) {
    hermits.remove(0);
  }
  while (hermits.size () < n) {
    hermits.add(new Hermit());
  }
}

void setHermitDiameter(float d) {
  hermitDiameter = d;
}

int numHermits() {
  return hermits.size ();
}

void draw() {
  fill(bgColor,20);
  rect(0,0,width,height);
  for (Hermit hermit : hermits) {
    hermit.move().drawIt();
  }
}

void mousePressed() {
  for (Hermit hermit : hermits) {
    hermit.dragIfSelected();
  }
}  

void mouseReleased() {
  for (Hermit hermit : hermits) {
    hermit.releaseDrag();
  }
}  
class Hermit {
  float x = random(width), y = random(height);
  float mass = 1;
  color c = color(255, 0, 0);
  boolean drag = false;

  void dragIfSelected() {
    drag  = (dist(x, y, mouseX, mouseY)<hermitDiameter);
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
    ellipse(x, y, hermitDiameter, hermitDiameter);
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
      float forceMultiplier = 5.0e8 / numHermits() / numHermits();
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
    if (d > maxD ) {
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

