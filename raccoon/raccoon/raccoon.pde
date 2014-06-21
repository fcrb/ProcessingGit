Raccoon rocky;

void setup() { 
  size(320, 180);
  rocky = new Raccoon(width/2, height/2);
}

void draw() {
  background(0);
  //have scale cycle up and down
  float scale = 4 * (1+0.5 * sin(millis() * 0.001));
  rocky.setScale(scale).drawIt();
}

class Raccoon {
  float x, y, scale;

  Raccoon(float x_, float y_) {
    x = x_;
    y = y_;
    scale = 1;
  }

  void drawIt() {
    //draw eyes
    fill(255);
    float eyeDiameter = width / 24 * scale;
    ellipse(x - eyeDiameter/2, y, eyeDiameter, 3 * eyeDiameter);
    ellipse(x + eyeDiameter/2, y, eyeDiameter, 3 * eyeDiameter);

    //draw pupils
    fill(0);
    float pupilDiameter = 0.8 * eyeDiameter;
    ellipse(x - eyeDiameter/2, y, pupilDiameter, pupilDiameter);
    ellipse(x + eyeDiameter/2, y, pupilDiameter, pupilDiameter);
  }

  Raccoon setScale(float s) {
    scale = s;
    return this;
  }
}


