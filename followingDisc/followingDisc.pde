int lastX;
int lastY;
int ballSize;

void setup() {
  size(630, 240);
  ballSize = 20;
  lastX = mouseX;
  lastY = mouseY;
  frameRate(90);
}

void draw() {
  background();
  float lastWeight = 0.93;
  lastX = lastWeight * lastX+ (1.0-lastWeight) * mouseX;
  lastY = lastWeight * lastY+ (1.0-lastWeight)* mouseY;
  ellipse(lastX, lastY, 
           Math.abs(lastX-mouseX)+10,  Math.abs(lastY-mouseY)+10);
}

