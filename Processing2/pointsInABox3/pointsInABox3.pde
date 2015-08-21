int numParticles = 30;
ArrayList<Particle> particles;
float side;
float halfSide;
//float pointSize= 3;
//int pointColor= color(100, 100, 255);

void setup() {
  size(640, 360, P3D);
  particles=  new ArrayList<Particle>();
  for (int i = 0; i < numParticles; ++i) {
    particles.add(new Particle());
  }
  side = height/2;
  halfSide = side/2;
}

void draw() {
  background(255);
//  lights();

  //make coordinates of center (0,0)
  translate(width/2, height/2, 0);

  //rotate to follow mouse
  float rotateScale = 0.01;
  rotateX((height/2-mouseY) * rotateScale);
  rotateY((mouseX-width/2) * rotateScale);

  //draw back wall of box
  fill(250, 200, 200);
  rectMode(CENTER);
  translate(0, 0, -halfSide);
  noStroke();
  rect(0, 0, side, side);
  translate(0, 0, halfSide);

  //draw dots inside box
  for (Particle particle: particles) {
    particle.draw();
  }

  //draw box frame
  noFill();
  stroke(100, 100);
  strokeWeight(1);
  box(side, side, side);
}
