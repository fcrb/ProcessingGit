void setup() {
  //set width and height equal
  size(480, 480);
}

void draw() {
  background(255);
  noStroke();
  //Rather than fixing alpha, let it cycle continuously from 0-255
  float alpha = 128 * (sin(millis() * 0.0005) + 1.0) ;
  float radius = height * 0.5;
  float topCircleCenterY = height / 2 - radius / 4;
  fill(255,0,0,alpha);
  ellipse(width/2, topCircleCenterY, radius, radius);
  fill(0,255,0,alpha);
  ellipse(width/2 - radius/3, topCircleCenterY + radius /2, radius,radius);
  fill(0,0,255,alpha);
  ellipse(width/2 + radius/3, topCircleCenterY + radius /2 , radius,radius);
  
  String msg = "alpha = "+((int)alpha);
  float tHeight = 32 * height / 480;
  textSize(tHeight);
  float tWidth = textWidth(msg);
  fill(150);
  text(msg, (width - tWidth)/2, tHeight);  
}

