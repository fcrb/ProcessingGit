color myColor = #FF0000;

void setup() {
  size(200, 20);
  noStroke();
  background(255);
}

void draw() {
  background(myColor);
}

// Call this from javascript in the web page
void setColor(color c) {
  myColor = unhex("55"+c);
}

