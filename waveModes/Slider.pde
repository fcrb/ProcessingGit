class Slider {
  float x, y, len, thickness;
  int minValue, maxValue, value, increment;
  boolean pressHandled = false;
  boolean mouseInSlider = false;
  String label;

  Slider(float x_, float y_, float len_, int min_, int max_, int inc_, String label_) {
    x = x_;
    y=y_;
    len = len_;
    minValue = min_;
    maxValue=max_;
    value = minValue;
    thickness = 6;
    increment = inc_;
    label=label_;
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
    fill(100);
    ellipse( ((float) value - minValue) / (maxValue - minValue) * len, 0
      , thickness * 4, thickness * 4);

    fill(255);
    int txtSize = 18;
    //units
    textSize(txtSize );
    text(""+value, len+3*thickness, txtSize/3);
    //label
    text(label, - (textWidth(label) + 4*thickness), txtSize/3);
    popMatrix();
  }
}

