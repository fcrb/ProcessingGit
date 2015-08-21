ArrayList<Hermit> hermits;
Hermit dragHermit;
float hermitDiameter = 20;
color bgColor = color(0);
boolean fade = false;
color unselectedColor = color(255, 0, 0);
color selectedColor = color(255, 255, 0);
String debug = "";

void setup() {
  size(480, 480);
  hermits = new ArrayList<Hermit>();
  setNumHermits(30);
  background(bgColor);
}

// Called from javascript in the browser.
void setNumHermits(int n) {
  while (hermits.size () > n) {
    hermits.remove(0);
  }
  while (hermits.size () < n) {
    hermits.add(new Hermit());
  }
}

// Called from javascript in the browser.
void setHermitDiameter(float d) {
  hermitDiameter = d;
}

// Called from javascript in the browser.
void setFade(boolean f) {
  fade = f;
}

// Called from javascript in the browser.
void setSelectedColor(color c) {
  selectedColor = colorFromJS(c);
}

// Called from javascript in the browser.
void setUnselectedColor(color c) {
  unselectedColor = colorFromJS(c);
}

color colorFromJS(color c) {
  return unhex("FF"+c);
}

int numHermits() {
  return hermits.size ();
}

void draw() {
  if (fade) {
    fill(bgColor, 20);
    rect(0, 0, width, height);
  } 
  else {
    background(bgColor);
  }
  for (Hermit hermit : hermits) {
    hermit.move().drawIt();
  }
  text(debug, width/2, height/2);
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
  color c = unselectedColor;
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
      c = unselectedColor;
    else {
      float fractionUnselected = min(1, dist(x, y, dragHermit.x, dragHermit.y)* 0.005);
      c = lerpColor(selectedColor, unselectedColor, fractionUnselected);
    }
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
    float radius = hermitDiameter * 0.5;
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

