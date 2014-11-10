boolean mouseIsBeingDragged = false;
int widthColorWheel = 225;
int heightColorWheel = 225;
int selectedColor = color(255);
int WHITE = color(255);
int BLACK = color(0);
PImage img;

void setup() {
  size(400, 300);
  background(255);
  img = loadImage("colorWheel.png" );
}

void draw() {
  if (mouseIsBeingDragged) {
    //draw the path being taken by the mouse point
    strokeWeight(8);
    noSmooth();
    stroke(0);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  //draw the color wheel and selected color swatch
  image(img, 0, 0);
  noStroke();
  fill(selectedColor);
  float radiusColorSwatch = 15;
  float diameterColorSwatch = radiusColorSwatch * 2;
  ellipse(radiusColorSwatch, radiusColorSwatch, diameterColorSwatch, diameterColorSwatch);
}

boolean inColorWheel(int x, int y) {
  return (x < widthColorWheel && y < heightColorWheel);
}

void mouseClicked() {
  if (inColorWheel(mouseX, mouseY) ) {
    loadPixels();
    selectedColor = pixels[width * mouseY + mouseX];
  } 
  else {
    fillPixels(mouseX, mouseY);
  }
}

void mouseDragged() {
  mouseIsBeingDragged = true;
}

void mouseMoved() {
  mouseIsBeingDragged = false;
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
  updatePixels();
}
