void setup() {
  size(320, 60);
  background(255);
  char[] captchaText = "734 230 2756".toCharArray();
  int charWidth = width / (captchaText.length + 1);
  int x = charWidth / 2;
  int y = height -charWidth;
  fill(0);
  for (char c : captchaText) {
    textSize(charWidth * 1.5);
    pushMatrix();
    translate(x, y);
    rotate(randomGaussian() *0.2);
    text(""+c, 0, 0);
    popMatrix();
    x += charWidth;
  }

  color BLACK = color(0, 0, 0);
  color WHITE = color(255, 255, 255);
  float threshold = 0.2;
  for (int i = 0; i < width; ++i) {
    for (int j = 0; j < height;++j) {
      float r = random(1);
      if (r < threshold) {
        set(i, j, (get(i, j) == BLACK) ? WHITE : BLACK);
      }
    }
  }
}
