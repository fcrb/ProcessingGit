class Robot {
  float x = 0;//location of robot
  float y = 0;//location of robot
  float scale = 1; //size of robot
  int robotColor;
  
  Robot(int robotColor_, float scale_) {
    robotColor = robotColor_;
    scale = scale_;
  }

  void moveTo(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void draw() {

    //draw a grid to help me draw my robot
    pushMatrix();
    noStroke();
    fill(robotColor);
    translate(x, y);

    //draw body of robot
    float bodyWidth = 100 * scale;
    float bodyHeight = 150 * scale;
    float yTopOfBody = -bodyHeight/2;
    rect(-bodyWidth/2, yTopOfBody, bodyWidth, bodyHeight);

    //draw neck of robot
    float neckWidth = 30 * scale;
    float neckHeight = 80*(1+cos(millis() * 0.001 / scale)) * scale;
    float yTopOfNeck = yTopOfBody - neckHeight;
    rect(-neckWidth/2, yTopOfNeck, neckWidth, neckHeight);

    //draw head of robot
    float headWidth = 140 * scale;
    float headHeight = 30 * scale;
    float yTopOfHead = yTopOfNeck - headHeight;
    rect(-headWidth/2, yTopOfHead, headWidth, headHeight);

    //draw eyes of robot
    float eyeDistanceFromCenter = headWidth *0.4;
    float eyeDiameter = headHeight * 0.7;
    float pupilDiameter = eyeDiameter * 0.5;
    float eyeYCenter = yTopOfHead + headHeight/2;
    fill(255);
    float eyeHeightScalar = 0.5 * (1 + cos(millis() * 0.001));
    ellipse(-eyeDistanceFromCenter, eyeYCenter, eyeDiameter, eyeDiameter * eyeHeightScalar);
    ellipse(eyeDistanceFromCenter, eyeYCenter, eyeDiameter, eyeDiameter * eyeHeightScalar);
    fill(0, 50);
    ellipse(-eyeDistanceFromCenter, eyeYCenter, pupilDiameter, pupilDiameter * eyeHeightScalar);
    ellipse(eyeDistanceFromCenter, eyeYCenter, pupilDiameter, pupilDiameter * eyeHeightScalar);
    popMatrix();
  }

  void easeTowards(float targetX, float targetY, float easing) {
    float dx = targetX - x;
    if (abs(dx) > 1) {
      x += dx * easing;
    }

    float dy = targetY - y;
    if (abs(dy) > 1) {
      y += dy * easing;
    }
  }
}
