void setup() {
  size(640,640);
  
}

void draw() {
  background(255);
  
  
  int eyeDiameter = width/4;
  fill(255);
  //eyes
  float xLeftEye = width/2 - eyeDiameter;
  float xRightEye = width/2 + eyeDiameter;
  float yLeftEye = height /2;
  float yRightEye = height /2;
  ellipse(xLeftEye, yLeftEye,eyeDiameter, eyeDiameter);
  ellipse(xRightEye, yRightEye,eyeDiameter, eyeDiameter);
  
  //pupils
  fill(0);
  int pupilDiameter = eyeDiameter/2;
  float distToMouse = dist(xLeftEye, yLeftEye, mouseX, mouseY);
  float xLeftPupil = (mouseX-xLeftEye) * 
  ellipse(mouseX,mouseY,pupilDiameter, pupilDiameter);

}
  
