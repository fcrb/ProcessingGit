ArrayList<SmokePuff> smoke;
void setup() {
  size(320, 240);
  background(0);
  smoke = new ArrayList<SmokePuff>();
}

class SmokePuff {
  float x, y, vx;
  int drawCount = 0;

  SmokePuff(float x_, float y_) {
    x = x_;
    y =y_;
    vx = 2;
  }

  void draw() {
    noStroke();
    float diameter = 5 * sqrt(drawCount);
    float alpha = min(255, 1000000/ (diameter * diameter * diameter)) ;
    if (alpha > 0) {
      fill(255, alpha);
      ellipse(x, y, diameter, diameter);
    }
    ++drawCount;
    x += vx;
  }

  void drawFrom(SmokePuff previousPuff) {
    ++drawCount;
    if(previousPuff ==  null) {
      return;
    }
    float diameter = 5 * sqrt(drawCount);
    float alpha = min(255, 1000000/ (diameter * diameter * diameter)) ;
    if (alpha > 0) {
      stroke(255, alpha);
      strokeWeight(diameter);
      line(x, y, previousPuff.x, previousPuff.y);
    }
    x += vx;
  }

  boolean isFaded() {
    return drawCount > 5000;
  }
}

void draw() {
  fill(255);
  smoke.add(new SmokePuff(mouseX, mouseY));
  ArrayList<SmokePuff> puffsToRemove = new ArrayList<SmokePuff>();
  SmokePuff previousPuff = null;
  for (SmokePuff puff : smoke) {
    puff.drawFrom(previousPuff);
    if (puff.isFaded() )
      puffsToRemove.add(puff);
    else {
      previousPuff = puff;
    }
  }
  smoke.removeAll(puffsToRemove);

  //  //fade screen
  noStroke();
  fill(0, 0, 0, 150);
  rect(0, 0, width, height);
}
