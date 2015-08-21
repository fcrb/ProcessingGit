int numBackgrounds = 120;
float perlinSpaceIncrement = 0.03;
float perlinTimeIncrement = 0.01;
ArrayList<Screenshot> screenshots = new ArrayList<Screenshot>();

void setup() {
  size(640, 360);
}

void draw() {
  if (frameCount <= numBackgrounds) {
    screenshots.add(new Screenshot());
  } 
  else {
    int frame = frameCount % (screenshots.size()*2-2);
    if (frame >= screenshots.size())
      frame = screenshots.size()*2 - 2 - frame;
    screenshots.get(frame).draw();
  }
  fill(255);
  text("fps = "+(int) (frameCount * 1000.0)/millis(), 20, 20);
}

class Screenshot {
  PImage img;

  Screenshot() {
    img = createImage(width, height, RGB);
    img.loadPixels();
    float t = frameCount * perlinTimeIncrement;
    for (int i = 0; i < width; ++i) {
      float x = i * perlinSpaceIncrement;
      for (int j = 0; j < height; ++j) {
        float y = j * perlinSpaceIncrement;
        float r = 0;//noise(x, y, t)*255;
        float g = map(noise(x+10, y+20, t), 0, 1, 0, 150);
        float b = map(noise(x+30, y+40, t), 0, 1, 200, 255);
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
