class Robot {
  float wHead;//width of head
  float x, y;//coordinates of bottom of head
  float easing;//how fast robot moves towards a new location
  float alphaLevel = 100;

  Robot(float headWidth, float easing_) {
    wHead = headWidth;
    x = width/2;
    y = height/2;
    easing = easing_;
  }

  void easeTowards(float x_, float y_) {
    x = x + easing * (x_ - x);
    y = y + easing * (y_ - y);
  }

  void drawRobot() {
    pushMatrix();
    //move (0,0) to the center of screen
    translate(x, y);

    //draw Head
    fill(220, alphaLevel);
    float hHead = wHead * 2 / 3;//height of head
    float rHead = wHead / 5;//radius of head corners
    rect(-wHead/2, -hHead, wHead, hHead, rHead);

    //draw Eyes
    fill(0, 0, 255, alphaLevel);
    float eyeDiameter = wHead / 10;
    ellipse(-wHead/3, -hHead/2, eyeDiameter, eyeDiameter);
    ellipse(wHead/3, -hHead/2, eyeDiameter, eyeDiameter);

    //draw mouth
    fill(255, 0, 0, alphaLevel);
    float wMouth = wHead * 0.35;
    float hMouth = hHead * 0.1;
    rect(-wMouth/2, -hHead * 0.2, wMouth, hMouth);

    //draw neck
    float wNeck = wHead * 0.25;
    float hNeck = wNeck * 2;
    rect(-wNeck/2, 0, wNeck, hNeck);

    popMatrix();
  }
}
