int numBackgrounds = 120;
ArrayList<Screenshot> screenshots = new ArrayList<Screenshot>();

void setup() {
  size(640, 360);
}

void draw() {
  if (frameCount <= numBackgrounds) {
    screenshots.add(new Screenshot());
  } 
  else {
    int frame = (frameCount - 1) % screenshots.size();
    screenshots.get(frame).draw();
    fill(0);
    ellipse(mouseX, mouseY, 30, 30);
  }
  fill(255);
  text("fps = "+(int) (frameCount * 1000.0)/millis(), 20, 20);
}

class Screenshot {
  PImage img;

  Screenshot() {
    img = createImage(width, height, RGB);
    img.loadPixels();
    float t = 2 * PI * frameCount / numBackgrounds;
    for (int i = 0; i < width; ++i) {
      float x = i * 2 * PI / width * 3;
      for (int j = 0; j < height; ++j) {
        float y = j * 2 * PI / height * 2;
        float r = map(cos(x*2+t)+cos(y*5+2*t) + cos(t), -3, 3, 0, 255);
        float g = map(cos(x+2*t)+cos(y*2.5-3*t) + cos(t), -3, 3, 0, 255);
        float b = map(cos(x*3.5-3*t)+cos(y+t) + cos(t), -3, 3, 0, 255);
        img.pixels[i + width * j] = color(r, g, b);
      }
    }
    img.updatePixels();
    draw();
  }

  void draw() {
    image(img, 0, 0);
  }
}
