int controlColor = 100;
Checkbox checkbox;
Knob knob;
Slider slider;

void setup() {
  size(480, 270);
  knob = new Knob(width/3, height/3, 100, 220, 880);
  slider = new Slider(20, height * 2 / 3, 200, 220, 1760, 20);
  checkbox = new Checkbox(width/2, 30, false, "Look, Ma, a checkbox!");
}

void draw() {
  background(255);
  knob.draw();
  slider.draw();
  checkbox.draw();
}
