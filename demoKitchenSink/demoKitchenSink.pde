Sprite[] sprites;

void setup() {
  size(640, 480);
  int numberOfSprites = 6;
  sprites = new Sprite[numberOfSprites];
  for (int i = 0; i < numberOfSprites; i = i + 1) {
    sprites[i] = new Sprite(0.99-i * 0.03);
  }
}

void draw() {
  background(255, 0, 0);
  println(frameCount);
  fill(0);
  text("frame count "+frameCount, 20, 20);
  text("frame rate "+(int)(frameCount * 1000.0 / millis()), 20, 40);
  for(Sprite sprite: sprites) {
    sprite.drawYourself();
  }
}

class Sprite {
  float x, y;
  float easing;

  Sprite(float easing_) {
    x = width * random(1);
    y = height * random(1);
    easing = easing_;
  }

  void drawYourself() {
    pushMatrix();
    float inputToSine = frameCount * 0.05;
    float sine = sin(inputToSine);//between -1 and 1
    float colorLevel = (sine + 1)  * 127;
    fill(0, 255-colorLevel, colorLevel);
    strokeWeight(5);
    float diameter = sine * 20 + 40;
    x = easing * x + (1-easing) * mouseX;
    y = easing * y + (1-easing) * mouseY;
    translate(x, y);
    rotate(frameCount*.01);
    ellipse(0, 0, diameter, diameter);
    line(-diameter/2, 0, diameter/2, 0);
    popMatrix();
  }
}
