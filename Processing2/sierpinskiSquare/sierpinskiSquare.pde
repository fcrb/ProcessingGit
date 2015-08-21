ArrayList<SingleGraphic> graphicList = new ArrayList<SingleGraphic>();
int maxLevel = 5;

void setup() {
  size(640, 640);

  int bgColor = 255;
  background(bgColor);
  float x = 0;//width * 0.05; 
  float y =  x;
  float side = width - 2 * x;
  fill(255, 0, 0);
  noStroke();
  new SingleGraphic(x, y, side).draw();

  fill(bgColor);
  generateFractal(x, y, side, 0);
  for(SingleGraphic graphic: graphicList)
    graphic.draw();
}

//void draw() {
//  if (frameCount >= graphicList.size())
//    return;
//  graphicList.get(frameCount - 1).draw();
//}


void generateFractal(float x, float y, float sideLength, int level) {
  if (level > maxLevel) {
    return;
  }
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
    rect(x, y, sideLength, sideLength);
  }
}
