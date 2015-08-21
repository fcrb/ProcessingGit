float heading1, heading2;

void setup() {
  size(240, 240);
  rectMode(CENTER);
  setHeading1(90);
  setHeading2(180);
  background(255);
  noStroke();
  smooth();
}

void draw() {
  fill(255,20); //fade the background gradually so you can see previous arrows gradually dim
  translate(width/2, height/2); //draw with 0,0 at center of sketch
  rect(0,0,width, height); //paint entire sketch to wipe clean (except for alpha fading)
  
  drawArrow(color(255,0,0,50), heading1);
  drawArrow(color(0,0,255,50), heading2);
  fill(200);
  ellipse(0,0,width * 0.1, width * 0.1);
}

void drawArrow(color c, float hdg) {
  pushMatrix();
  fill(c);//arrow will be white
  rotate( hdg * PI / 180.0); //rotate to heading, allows drawing everything north-oriented
  rect(0,0, width *0.10, height * 0.8); //draw north pointing arrow 
  triangle(-width * 0.10, -height*0.4, width * 0.10, -height*0.4, 0, -height * 0.45);
  popMatrix();
}

void setHeading1(float h) {
  heading1 = h;
}

void setHeading2(float h) {
  heading2 = h;
}

