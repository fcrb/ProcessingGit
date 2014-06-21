
class Benson {
  float x;
  float y;
  float headDiameter = width * 0.5;
  ArrayList<GumBall> gumballs;
  
  Benson() {
    gumballs = new ArrayList<GumBall>();
  }

  void draw() {
    noFill();
//    x = width * 0.5;
//    y = height * 0.5;

    strokeWeight(width*0.008);
    translate(mouseX, mouseY);
  rotate( (mouseX - width/2) * 0.02);
    //hat
    pushMatrix();
    rectMode(CENTER);
    rotate(-0.1*PI);
    fill(255, 0, 0);
    rect(0, -headDiameter *0.5, headDiameter * 0.05, headDiameter * 0.2); 
    rect(0, -headDiameter *0.5, headDiameter * 0.4, headDiameter * 0.08); 
    popMatrix();
    //gumballs

    //head
    fill(240);
    ellipse(0, 0, headDiameter, headDiameter);
    arc(0, 0, headDiameter * 0.92, headDiameter * 0.92, 0.8 * PI, 1.2 * PI);
    //upper brow
    float browLength = headDiameter /4;
    float yBrow = -headDiameter /4;
    line(- browLength/2, yBrow, browLength/2, yBrow);
    //lower brow
    browLength = browLength * 2;
    yBrow += headDiameter /20;
    line(- browLength/2, yBrow, browLength/2, yBrow);
    // eyes
    fill(255);
    float eyeDiameter = headDiameter / 6;
    float yEye = yBrow + eyeDiameter/2;
    ellipse(-eyeDiameter/2, yEye, eyeDiameter, eyeDiameter);
    ellipse(eyeDiameter/2, yEye, eyeDiameter, eyeDiameter);
    noFill();
    arc(-eyeDiameter/2, yEye, eyeDiameter*1.3, eyeDiameter*1.3, 0.3 * PI, 0.7 * PI);
    arc(eyeDiameter/2, yEye, eyeDiameter*1.3, eyeDiameter*1.3, 0.3 * PI, 0.7 * PI);
    // pupils
    float pupilDiameter = eyeDiameter / 8;
    fill(0);
    ellipse(-eyeDiameter/4, yEye, pupilDiameter, pupilDiameter);
    ellipse(3*eyeDiameter/4, yEye, pupilDiameter, pupilDiameter);
    //nose
    fill(220);
    float noseLength = eyeDiameter*1.6;
    triangle(0, yEye, noseLength*0.7, yEye+ noseLength, 0, yEye + noseLength);
    //mouth
    float xMouthCenter = -noseLength*0.38;
    float yMouthCenter = yEye+noseLength * 1.3 ;
    noFill();
    arc(xMouthCenter, yMouthCenter, noseLength*1.3, noseLength*1.3, 1.3 * PI, 1.7 * PI);
  }
}
