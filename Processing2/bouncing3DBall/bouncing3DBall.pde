//import processing.opengl.*;

float vx, vy, vz;
float x, y, z;
float ballRadius = 20;

void setup() {
  size(480, 270, OPENGL);
  vx = 1; 
  vy = 0; 
  vz = 1.5;
  x = 0; 
  y = 0; 
  z = 0;
  lights();
}

void draw() {
  background(255);

  stroke(0, 0, 255);
  translate(width/2, height/2, 0);
  rotateX((height/2 - mouseY) * 0.003);
  rotateY((mouseX - width/2) * 0.003);
  //  rotateX(PI * .45);
  float w = width/3;
  float h = width/3;
  noFill();
  box(w, h, h);

  stroke(255, 0, 0);
  x += vx;
  if(abs(x) > w/2 - ballRadius) {
    vx = - abs(vx) * sign(x);
  }
  
  y += vy;
  vy += 0.02;
  if(y > h/2-ballRadius) {
    vy = - abs(vy);
  }
  
  z += vz;
  if(abs(z) > h/2-ballRadius) {
    vz = - abs(vz)* sign(z);
  }

  translate(x,y,z);
  fill(255,0,0);
//  specular(255 );
//  lightSpecular(255, 255, 255 );
  sphere(ballRadius);
}

int sign(float a) {
  return a > 0 ? 1 : -1;
}
