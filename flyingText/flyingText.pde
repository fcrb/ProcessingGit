color bgColor = color(0); //<>//
ArrayList<ImageFragment> imageFragments;
int fragmentSize = 40;

void setup() {
  //choose dimensions that are multiples of fragmentSize
  size(640, 120);
  background(0);
  int fontSize = 96;
  textSize(fontSize);
  text("Hello, world.", fontSize/3, fontSize);
  loadPixels();
  imageFragments = new ArrayList<ImageFragment>( width * height / fragmentSize / fragmentSize);
  for (int y = 0; y < height / fragmentSize; y++) {
    for (int x = 0; x < width / fragmentSize; x++) {
      int[] fragPix = new int[fragmentSize * fragmentSize];
      for (int pixCtr = 0; pixCtr < fragPix.length; ++pixCtr) {
        fragPix[pixCtr] = pixels[x * fragmentSize + y * width + pixCtr];
      }
      for (int yFrag = 0; yFrag < fragmentSize; ++yFrag) {
        for (int xFrag = 0; xFrag < fragmentSize; ++xFrag) {
          fragPix[xFrag  + yFrag * fragmentSize] = pixels[x * fragmentSize + xFrag + (y * fragmentSize + yFrag) * width];
        }
      }
      imageFragments.add(new ImageFragment(x, y, fragPix));
    }
    updatePixels();
  }
  frameRate(2);
}

void draw() {
  background(255);
  loadPixels();
  for (ImageFragment imageFragment : imageFragments) {
    imageFragment.display();
  }
  updatePixels();
}

class ImageFragment {
  int fragX, fragY;
  int[] fragPix;
  ImageFragment(int x_, int y_, int[] fragPix_) {
    fragX = x_;
    fragY=y_;
    fragPix = fragPix_;
  }

  void display() {
    displayAt(fragX * fragmentSize, fragY * fragmentSize);
  }

  void displaySwapped() {
    displayAt((maxFragX() - fragX) * fragmentSize, (maxFragY() - fragY) * fragmentSize);
  }

  void displayAt(int x_, int y_) {
    for (int y = 0; y < fragmentSize; y++) {
      for (int x = 0; x <   fragmentSize; x++) {
        pixels[x_ + x + (y_+y) * width] = fragPix[x + y * fragmentSize];
      }
    }
  }
  
  int maxFragX() {
    return width / fragmentSize - 1;
  }
 
  int maxFragY() {
    return height / fragmentSize - 1;
  }
}
