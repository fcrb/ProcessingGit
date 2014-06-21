class Slider {
  float x, y, len, thickness;
  int minValue, maxValue, value, increment;
  boolean pressHandled = false;
  boolean mouseInSlider = false;

  Slider(float x_, float y_, float len_, int min_, int max_, int inc_) {
    x = x_;
    y=y_;
    len = len_;
    minValue = min_;
    maxValue=max_;
    value = minValue;
    thickness = 6;
    increment = inc_;
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    if (mousePressed) {
      if (!pressHandled) {
        mouseInSlider = mouseX >= x && mouseX <= x + len 
          && mouseY < y + thickness && mouseY > y - thickness;
        pressHandled = true;
      } 
      if (mouseInSlider) {
        float v = minValue + (maxValue - minValue) * (mouseX - x) / len;
        value = increment * (int) round(v /  increment);
        if (value < minValue) value = minValue;
        if (value > maxValue) value = maxValue;
      }
    } 
    else {
      mouseInSlider = false;
      pressHandled = false;
    }

    stroke(200);
    strokeWeight(thickness);
    line(0, 0, len, 0);
    noStroke();
    fill(controlColor);
    ellipse( ((float) value - minValue) / (maxValue - minValue) * len, 0, thickness * 2, thickness * 2);
    int txtSize = 14;
    textSize(txtSize );
    text(""+value, len+10, txtSize/3);
    popMatrix();
  }
}
