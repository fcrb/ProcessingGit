class Eye {
  float x, y;
  float diameter;
  float pupilDiameter;

  Eye(float x_, float y_, float diameter_, float pupilDiameter_) {
    x= x_; 
    y = y_;
    diameter = diameter_;
    pupilDiameter = pupilDiameter_;
  }

  void draw() {
    fill(255);
    ellipse(x, y, diameter, diameter);
    float angle = atan((y - mouseY)/(x-mouseX));
    if (x-mouseX > 0) angle += PI;
    float pupilCenterRadius = (diameter - pupilDiameter) * 0.5;
    float xPupilCenter = pupilCenterRadius * cos(angle);
    float yPupilCenter = pupilCenterRadius * sin(angle);
    fill(0);
    ellipse(x + xPupilCenter, y + yPupilCenter, pupilDiameter, pupilDiameter);
  }
}
