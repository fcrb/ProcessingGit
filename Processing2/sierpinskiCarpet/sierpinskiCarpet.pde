int maxLevel = 7;//depth of recursion
int numFrames = 3 * 30;//3 seconds at 30 frames/second

void setup() {
  size(720, 720);//720 for 720p movie
}

void draw() {
  drawFrame(frameCount  - 1);
}

void drawFrame(int frame) {
  if (frame >= numFrames) return;
  float side = width * pow(3, ((float)frame) / numFrames);
  float x = (width - side) * 0.5;
  float y =  0;

  color bgColor = color(0, 0, 80);
  background(bgColor);

  color fgColor = 255;
  fill(fgColor);
  noStroke();

  generateFractal(x, y, side, 0);
  saveFrame("square-####.png");
}


void generateFractal(float x, float y, float sideLength, int level) {
  if (level > maxLevel) return;
  float sl3 = sideLength / 3;
  //draw only if it is onscreen
  if (x + sl3 < width && y + sl3 < height) 
    //draw the white square in the middle
    rect(x + sl3, y + sl3, sl3, sl3);
  int newLevel = level + 1;
  //create fractals in surrounding 8 squares
  generateFractal(x, y, sl3, newLevel);
  generateFractal(x, y + sl3, sl3, newLevel);
  generateFractal(x, y + 2 * sl3, sl3, newLevel);
  generateFractal(x+ sl3, y, sl3, newLevel);
  generateFractal(x+ sl3, y + 2 * sl3, sl3, newLevel);
  generateFractal(x + 2 * sl3, y, sl3, newLevel);
  generateFractal(x + 2 * sl3, y + sl3, sl3, newLevel);
  generateFractal(x + 2 * sl3, y + 2 * sl3, sl3, newLevel);
}
