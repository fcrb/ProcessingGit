ArrayList<Triangle> triangles = new ArrayList<Triangle>();
int maxLevel = 7;

void setup() {
  size(640, 555);

  int bgColor = 255;
  background(bgColor);
  float fractionAcross = 0.1;
  float x1=width/2; 
  float y1 =  height * fractionAcross;
  float x2=width * fractionAcross;
  float y2=height * (1-fractionAcross);
  float x3=width * (1-fractionAcross); 
  float y3= height * (1-fractionAcross);
  fill(255, 0, 0);
  noStroke();
  triangle(x1, y1, x2, y2, x3, y3);

  fill(bgColor);
  generateSierpinski(x1, y1, x2, y2, x3, y3, 0);
}

void draw() {
  if (frameCount >= triangles.size())
    return;
  triangles.get(frameCount - 1).draw();
}


void generateSierpinski(float x1, float y1, float x2, float y2, float x3, float y3, int level) {
  if (level > maxLevel) {
    return;
  }
  triangles.add(new Triangle((x1 + x2) * 0.5, (y1 + y2) * 0.5, (x1 + x3) * 0.5, (y1 + y3) * 0.5, (x2 + x3) * 0.5, (y2 + y3) * 0.5));
  generateSierpinski(x1, y1, (x1 + x2) * 0.5, (y1 + y2) * 0.5, (x1 + x3) * 0.5, (y1 + y3) * 0.5, level + 1);
  generateSierpinski((x1 + x2) * 0.5, (y1 + y2) * 0.5, x2, y2, (x2 + x3) * 0.5, (y2 + y3) * 0.5, level + 1);
  generateSierpinski((x1 + x3) * 0.5, (y1 + y3) * 0.5, (x2 + x3) * 0.5, (y2 + y3) * 0.5, x3, y3, level + 1);
}

class Triangle {
  float x1, y1, x2, y2, x3, y3;

  Triangle(float x1_, float y1_, float x2_, float y2_, float x3_, float y3_) {
    x1=x1_;
    y1=y1_;
    x2=x2_;
    y2=y2_;
    x3=x3_;
    y3=y3_;
  }

  void draw() {
    triangle(x1, y1, x2, y2, x3, y3);
  }
}

