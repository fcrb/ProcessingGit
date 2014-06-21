Raccoon rocky;

void setup() { 
  size(320, 180);
  rocky = new Raccoon(width/2, height/2);
}

void draw() {
  background(0);
  noStroke();
  //let scale increase and decrease cyclically
  float scale = 2; // * (1+0.3 * sin(millis() * 0.001));
  rocky.setScale(scale).rotateTowards(mouseX, mouseY).drawIt();
}

class Raccoon {
  float x, y;//coordinates of Raccoon, representing point between the eyes
  float scale;//a multiplier that allows us to draw a raccoon at any scale
  float rotationAngleInRadians = 0;

  Raccoon(float x_, float y_) {
    x = x_;
    y = y_;
    scale = 1;
  }

  void drawIt() {
    translate(x, y);
    rotate(rotationAngleInRadians);
    float baseSize = width * scale;

    //draw body
    fill(140, 70, 20);
    ellipse(0, -baseSize * 0.06, -baseSize * 0.06, baseSize * 0.12);

    //draw tail
    float fillColor = 50;
    for (int i = 0; i < 9; ++i) {
      fill(fillColor);
      fillColor = 255-fillColor;
      ellipse(0, -baseSize * (0.12 + 0.005 * i), -baseSize * 0.02, baseSize * 0.03);
    }

    //draw nose
    fill(140, 70, 20);
    beginShape();
    vertex(0, baseSize * 0.06);
    vertex(-baseSize * 0.02, 0);
    vertex(baseSize * 0.02, 0);
    vertex(0, baseSize * 0.06);
    // etc;
    endShape();
    fill(255,0,0);
    ellipse(0,baseSize * 0.06, 10,10);

    //draw ears, referenced from ears (drawn later)
    float eyeDiameter = baseSize * 0.02;
    float leftEyecenter =  - eyeDiameter/2;
    float rightEyecenter =  eyeDiameter/2;
    float eyeHeightToWidthRatio = 3;
    float eyeHeight = 2 * eyeDiameter;
    float earBaseHeight =  -eyeHeight/2;
    fill(100, 50, 20);//dark brown
    for (int sign = -1; sign < 2; sign += 2) {
      beginShape();
      vertex(sign * eyeDiameter/2, earBaseHeight * 1.5);
      vertex(sign * eyeDiameter/4, earBaseHeight );
      vertex(sign * eyeDiameter* 0.75, earBaseHeight );
      vertex(sign * eyeDiameter/2, earBaseHeight * 1.5);
      // etc;
      endShape();
    }

    //draw white eyes
    fill(255);
    ellipse(leftEyecenter, 0, eyeDiameter, eyeHeight);
    ellipse(rightEyecenter, 0, eyeDiameter, eyeHeight);

    //draw black pupils
    fill(0);
    float pupilDiameter = eyeDiameter * 0.6;
    ellipse(leftEyecenter, pupilDiameter, pupilDiameter, pupilDiameter);
    ellipse(rightEyecenter, pupilDiameter, pupilDiameter, pupilDiameter);
  }

  Raccoon rotateTowards(float pointToX, float pointToY) {
    //a bit of trig...
    rotationAngleInRadians = atan( (pointToY - y) / (pointToX - x) ) ;
    // because we drew our raccoon already rotated facing down...
    rotationAngleInRadians -= PI/2;

    //now, deal with the fact that atan may be off by 180 degrees,
    //so we may need to add PI radians
    if (pointToX == x) {
      if ( pointToY < y ) {
        rotationAngleInRadians += PI;
      }
      return this;
    }
    if (pointToX < x)
      rotationAngleInRadians += PI;
    return this;
  }

  Raccoon setScale(float s) {
    scale = s;
    return this;
  }
}


