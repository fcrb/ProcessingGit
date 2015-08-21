class Checkbox {
  float x, y, boxWidth = 18;
  boolean checked = false;
  boolean pressHandled = false;
  String label;

  Checkbox(float x_, float y_, boolean checked_, String label_) {
    x = x_;
    y=y_;
    checked = checked_;
    label = label_;
  }

  boolean mouseInCheckBox() {
    return mouseX >= x && mouseX <= x + boxWidth 
      && mouseY < y + boxWidth && mouseY > y - boxWidth;
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    if (mousePressed) {
      if (!pressHandled) {
        pressHandled = true;
      }
    } 
    else {
      if (pressHandled && mouseInCheckBox())
        checked = !checked;
      pressHandled = false;
    }

    stroke(controlColor);
    strokeWeight(2);
    noFill();
    rect(0, -boxWidth, boxWidth, boxWidth);
    fill(controlColor);
    if (checked) {
      int inset = 4;
      noStroke();
      rect(0 + inset, -boxWidth+inset, boxWidth-2*inset+1, boxWidth-2*inset+1);
    }
    textSize(boxWidth );
    text(label, boxWidth+5, 0);
    popMatrix();
  }
}
