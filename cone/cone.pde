Cone cone;

void setup()
{
  size(450, 450, P3D);
  fill(255, 255, 0);
  cone = new Cone(0,0,0, 30, 50, 250, false, color(100,100,255));
}

void draw()
{
  background(0);
  lights();
  translate(width/2, height/2, 0);
  cone.draw();
}

