//int maxLevel = 5;//depth of recursion 
int numFrames = 9 * 30 ;//3 seconds at 30 frames/second 

void setup() { 
  size(720, 720);//720 for 720p movie
} 

void draw() { 
  if (frameCount <= numFrames)
    drawFrame(frameCount - 1);
}

void drawFrame(int frame) {
  int numZooms = 4;
  float side = width * pow(3 * numZooms, ((float)frame) / numFrames); 
  float x = (width - side) * 0.5; 
  float y = 0; 
  color bgColor = color(255); 
  background(bgColor); 
  color fgColor = 50; 
  fill(fgColor); 
  noStroke(); 
  generateFractal(x, y, side, 0); 
  saveFrame("square-####.png");
} 
void generateFractal(float x, float y, float sideLength, int level) { 
//  if (level > maxLevel) return; 
  float sl3 = sideLength / 3; //draw only if it is onscreen
  if (sl3 < 1) return;
  if (x + sideLength < 0 || y + sideLength < 0 || x > width || y > height)
    return;
  Point center = new Point ( x + sideLength/2, y +sideLength/2); 
  Point[] corners = new Point[4]; 
  corners[0] = new Point (x + sl3, y + sl3); 
  corners[1] = new Point (x + 2 * sl3, y + sl3); 
  corners[2] = new Point (x + 2 * sl3, y + 2 * sl3); 
  corners[3] = new Point (x + sl3, y + 2 * sl3); 
  for (Point p: corners) { 
    p.rotate(center, level * PI/16);
  } 
  quad(corners[0].x, corners[0].y, corners[1].x, corners[1].y, corners[2].x, corners[2].y, corners[3].x, corners[3].y); 
  int newLevel = level + 1; //create fractals in surrounding 8 squares 
  generateFractal(x, y, sl3, newLevel); 
  generateFractal(x, y + sl3, sl3, newLevel); 
  generateFractal(x, y + 2 * sl3, sl3, newLevel); 
  generateFractal(x+ sl3, y, sl3, newLevel); 
  generateFractal(x+ sl3, y + 2 * sl3, sl3, newLevel); 
  generateFractal(x + 2 * sl3, y, sl3, newLevel); 
  generateFractal(x + 2 * sl3, y + sl3, sl3, newLevel); 
  generateFractal(x + 2 * sl3, y + 2 * sl3, sl3, newLevel);
} 
class Point { 
  float x, y; 
  Point(float x_, float y_) { 
    x = x_; 
    y = y_;
  } 
  void rotate(Point origin, float angle) { 
    float cosA = cos(angle); 
    float sinA = sin(angle); 
    float tempX = origin.x + cosA * (x - origin.x) + sinA * (y - origin.y); 
    y = origin.y + sinA * (x - origin.x) - cosA * (y - origin.y);
    x = tempX;
  }
}

