class Robot {
  float wHead;//width of head
  float x, y;//coordinates of bottom of head

  Robot(float headWidth) {
    wHead = headWidth;
    x = width/2;
    y = height/2;
  }

  void easeTowards(float x_, float y_) {
    float easing = 0.05;
//    x = x * (1-easing) + x_ * easing;
//    y = y * (1-easing) + y_ * easing;
    x = x + easing * (x_ - x);
    y = y + easing * (y_ - y);
  }

  void drawRobot() {
    pushMatrix();
    //move (0,0) to the center of screen
    translate(x, y);

    //draw Head
    fill(220);
    float hHead = wHead * 2 / 3;//height of head
    float rHead = wHead / 5;//radius of head corners
    rect(-wHead/2, -hHead, wHead, hHead, rHead);

    //draw Eyes
    fill(0, 0, 255);
    float eyeDiameter = wHead / 10;
    ellipse(-wHead/3, -hHead/2, eyeDiameter, eyeDiameter);
    ellipse(wHead/3, -hHead/2, eyeDiameter, eyeDiameter);

    //draw mouth
    fill(255, 0, 0);
    float wMouth = wHead * 0.35;
    float hMouth = hHead * 0.1;
    rect(-wMouth/2, -hHead * 0.2, wMouth, hMouth);
    popMatrix();
  }
}
