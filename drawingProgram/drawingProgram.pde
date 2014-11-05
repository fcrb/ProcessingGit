boolean mouseIsBeingDragged = false;
int widthColorWheel = 225;
int heightColorWheel = 225;
//int wheelInset = 10;
int selectedColor = color(255);
int WHITE = color(255);
int BLACK = color(0);
PImage img;

void setup() {
  size(800, 600);
  background(255);
  img = loadImage("colorWheel.png" );
}

void draw() {
  if (mouseIsBeingDragged) {
    strokeWeight(8);
    noSmooth();
    stroke(0);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  image(img, 0, 0);
  noStroke();
  fill(selectedColor);
  float radiusColorSwatch = 15;
  float diameterColorSwatch = radiusColorSwatch * 2;
  ellipse(radiusColorSwatch, radiusColorSwatch, diameterColorSwatch, diameterColorSwatch);
}

void fillPixel(int x, int y) {
  if (selectedColor == WHITE) {
    return;
  }
  if (inColorWheel(x, y) || x < 1 || x >= width || y < 1 || y >= height) {
    return;
  }
  int pxlIndex = y * width + x;
  int pxl = pixels[pxlIndex];
  if (pxl == BLACK) {
    return;
  }
  if (pxl == WHITE) {
    pixels[pxlIndex] = selectedColor;
    fillPixel(x, y - 1);
    fillPixel(x, y + 1);
    fillPixel(x - 1, y);
    fillPixel(x + 1, y);
  }
}


void fillPixels(int x, int y) {
  ArrayList<Point> pixelsToFill = new ArrayList<Point>();
  pixelsToFill.add(new Point(x, y));

  while (pixelsToFill.size () > 0) {
    Point point = pixelsToFill.get( 0);//pixelsToFill.size() - 1);
    int pxlIndex = point.y * width + point.x;
    int pxl = pixels[pxlIndex];
    if (pxl != WHITE) {
      pixelsToFill.remove(point);
    }
    else {
      pixels[pxlIndex] = selectedColor;
      for (int dx = -1; dx < 2; ++dx) {
        for (int dy = -1; dy < 2; ++dy) {
          int x_ =point.x + dx;
          int y_ =point.y + dy;
          if (x_ > 0 && x_ < width && y_>0 && y_ < height) {
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
}

boolean mouseInColorWheel() {
  return inColorWheel(mouseX, mouseY);
}

boolean inColorWheel(int x, int y) {
  return (x < widthColorWheel && y < heightColorWheel);
}

void mouseClicked() {
  loadPixels();
  if (mouseInColorWheel() ) {
    selectedColor = pixels[width * mouseY + mouseX];
  } 
  else {
    fillPixels(mouseX, mouseY);
    updatePixels();
  }
}

void mouseDragged() {
  mouseIsBeingDragged = true;
}

void mouseMoved() {
  mouseIsBeingDragged = false;
}
