void mrb(float x, float y, float size) {
  pushMatrix();
  textFont(logoFont);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(size);
  translate(x, y);
  text("m", 0, 0);
  textSize(size * 0.7);
  text("r", textWidth("m"), size * 0.35);
  text("\u03B2", textWidth("m")*1.1, -size * 0.3);
  popMatrix();
}

