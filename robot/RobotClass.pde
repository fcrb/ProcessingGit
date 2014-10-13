class Robot {
  float x, y;
  float scale = 4;

  void goTo(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void draw() {
    pushMatrix();
    noStroke();
    translate(x, y);
    float bodyWidth  = 20 * scale;
    float bodyHeight = 40 * scale;
    //neck
    //    float neckHeight = bodyHeight * 0.2* (1 + cos(millis()*0.005));
    float neckHeight = bodyHeight * 0.2;
    float yNeckTop = - bodyHeight * 0.5 - neckHeight;
    float neckWidth = bodyWidth * 0.5;
    fill(0, 0, 255);
    rect(-neckWidth/2, yNeckTop, neckWidth, neckHeight);
    //head
    float headHeight = bodyWidth * 0.6;
    float yHeadTop = yNeckTop - headHeight;
    float headWidth = bodyWidth * 1.5;
    fill(0, 255, 0);
    rect(-headWidth/2, yHeadTop, headWidth, headHeight);
    //eyes
    float eyeDiameter = headHeight  * 0.6;
    float pupilDiameter = eyeDiameter  * 0.6;
    float xDistFromCenter  = headWidth * 0.3;
    float yEye = yHeadTop + headHeight/2;
    Eye eye = new Eye(xDistFromCenter, yEye, eyeDiameter, pupilDiameter);
    eye.draw();
    eye = new Eye(-xDistFromCenter, yEye, eyeDiameter, pupilDiameter);
    eye.draw();
    //body
    fill(255, 0, 0);
    rect(- bodyWidth/2, - bodyHeight/2, bodyWidth, bodyHeight);
    popMatrix();
  }
}
