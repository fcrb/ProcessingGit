import processing.pdf.*;
PFont logoFont, numberFont;

void setup() {
  size(320, 320);//, PDF, "fontTest.pdf");
  // Uncomment the following two lines to see the available fonts 
  String[] fontList = PFont.list();
  for (String font : fontList) {
    if (font.length() > 7 && font.substring(0, 3).equals("CMU"))
      println(font);
  }
  float size = 100;
  logoFont = createFont("CMUSerif-Italic", size); //"CMUSerif-Italic", 32);
  numberFont = createFont("CMUSerif-Roman", size); //"CMUSerif-Italic", 32);

  mrb(width/2, height/2, size);
}

void mrb(float x, float y, float size) {
  pushMatrix();
  textFont(logoFont);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(size);
  translate(x, y);
  text("m", 0, 0);
  textSize(size * 0.7);
  text("r", textWidth("m"), size * 0.35);
  text("\u03B2", textWidth("m")*1.1, -size * 0.3);
  popMatrix();
}

