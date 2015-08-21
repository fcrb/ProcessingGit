int numBlurlevels = 20;
float t = 0, y = noise(0);
int x = -1;
int DOT_RADIUS = 10;
float TIME_INCREMENT = 0.10;

void setup() {
  size(320, 240);
  background(0);
  frameRate(100);
}

void draw() {
  // The noise(t) function is a continuous, pseudorandom function 
  // with domain (0,1). It is seeded once at app start, after that 
  // it is deterministic. In other words, noise(a) == noise(b)
  // for a == b.

  // Scale y coordinate so that it is on average in the center. 
  for (int i = 0; i < 15;++i) {
    y = (int) (height / 2 + height * sin(t) * 0.3 );
    // x resets to zero when it hits the edge of the window.
    x = ++x % width;
    //change color when at the left edge
    if (x == 0) {
      color c = color((int) (noise(t)*256), (int) (noise(t+100)*256), (int) (noise(t+200)*256), 50);
      stroke(c);
      fill(c);
    }
    ellipse(x, y, DOT_RADIUS, DOT_RADIUS);
    t += TIME_INCREMENT;
  }
}

