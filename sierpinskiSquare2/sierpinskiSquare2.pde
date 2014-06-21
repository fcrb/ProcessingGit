ArrayList<SingleGraphic> graphicList;
int maxLevel = 6;

void setup() {
  size(1280, 720);
}

void draw() {
  int frameIncrement = 900;
  drawFrame(frameCount * frameIncrement);
}

void drawFrame(int frame) {
  if (frame >= width * 2) return;
  graphicList = new ArrayList<SingleGraphic>();
  color bgColor = color(0, 0, 200);
  color fgColor = color(0,255,0);
  background(bgColor);
  float x = 0;//width * 0.05; 
  float y =  x;
  float side = width + frame;

  fill(fgColor);
  noStroke();
  new SingleGraphic(x, y, side).draw();

  fill(bgColor);
  generateFractal(x, y, side, 0);
  for (SingleGraphic graphic: graphicList)
    graphic.draw();
  saveFrame("square-####.png");
}


void generateFractal(float x, float y, float sideLength, int level) {
  if (level > maxLevel) return;
  if (x > width || y > height || sideLength < 2 ) return;
  float sl3 = sideLength / 3;
  int newLevel = level + 1;
  graphicList.add(new SingleGraphic(x + sl3, y + sl3, sl3));
  generateFractal(x, y, sl3, newLevel);
  generateFractal(x, y + sl3, sl3, newLevel);
  generateFractal(x, y + 2 * sl3, sl3, newLevel);
  generateFractal(x+ sl3, y, sl3, newLevel);
  generateFractal(x+ sl3, y + 2 * sl3, sl3, newLevel);
  generateFractal(x + 2 * sl3, y, sl3, newLevel);
  generateFractal(x + 2 * sl3, y + sl3, sl3, newLevel);
  generateFractal(x + 2 * sl3, y + 2 * sl3, sl3, newLevel);
}

class SingleGraphic {
  float x, y, sideLength;

  SingleGraphic(float x_, float y_, float sideLength_) {
    x=x_;
    y=y_;
    sideLength=sideLength_;
  }

  void draw() {
    if (x > width || y > height) return;
    rect(x, y, sideLength, sideLength);
  }
}
