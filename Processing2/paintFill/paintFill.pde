int selectedColor = color(255, 0, 0);
int colorToReplace = color(255);

void setup() {
  size(320, 240);
  background(255);
  strokeWeight(8);
  noFill();
  noSmooth();
  ellipse( width/3, height/3, width/2, height/2);
  ellipse( width/2, height/2, 2* width/3, 2 * height/3);

  removeSmoothingForProcessingJS();
}

void removeSmoothingForProcessingJS() {
  loadPixels();
  for (int i = 0; i < pixels.length; ++i) {
    if (pixels[i] != color(0)) {
      pixels[i] = color(255);
    }
  }
  updatePixels();
}

void draw() {
  fill(0);
  String message = "r=red  g=green  b=blue  y=yellow";
  textSize(18);
  text(message, (width - textWidth(message))/2, height - 6);
}

void mouseClicked() {
  fillPixels(mouseX, mouseY);
}

void keyPressed() {
  if (key == 'r') {
    selectedColor = color(255, 0, 0);
  } 
  if (key == 'g') {
    selectedColor = color(0, 255, 0);
  }
  if (key == 'b') {
    selectedColor = color(0, 0, 255);
  }
  if (key == 'y') {
    selectedColor = color(255, 255, 0);
  }
}

class Point {
  int x, y;

  Point(int x_, int y_) {
    x = x_; 
    y = y_;
  }
}

void fillPixels(int x, int y) {
  loadPixels();
  ArrayList<Point> pixelsToFill = new ArrayList<Point>();
  pixelsToFill.add(new Point(x, y));

  while (pixelsToFill.size () > 0) {
    Point point = pixelsToFill.get( 0);
    int pxlIndex = point.y * width + point.x;
    int pxl = pixels[pxlIndex];
    if (pxl != colorToReplace) {
      pixelsToFill.remove(point);
    }
    else {
      pixels[pxlIndex] = selectedColor;
      for (int dx = -1; dx < 2; ++dx) {
        for (int dy = -1; dy < 2; ++dy) {
          int x_ =point.x + dx;
          int y_ =point.y + dy;
          if (x_ >= 0 && x_ < width && y_>=0 && y_ < height) {
            if (x_ != 0 || y_ != 0) {
              int pxlToAddIndex = y_ * width + x_;
              int pxl_ = pixels[pxlToAddIndex];
              if (pxl_ != selectedColor) {
                pixelsToFill.add(new Point(x_, y_));
              }
            }
          }
        }
      }
    }
  }
  updatePixels();
}

