import processing.opengl.*;

void setup()
{
  size(450, 450, P3D);
  fill(255, 255, 0);

  background(0);
  lights();
  //ambientLight(200, 200, 200);

//  pushMatrix();    
  translate(width/2, height/2, 0);
//  rotateX(0.01376482 * frameCount);
//  rotateY(0.01076482 * frameCount);
  rotateX(-PI/2);
  drawTree(30, 50, 250, 0);
//  popMatrix();
}

void drawTree(int numSides, float x, float y, float h, int level) {
  if(level > 2) return;
  
  //hmm---needs thought
  drawCone(numSides, x , h,  false);
  float scale = 0.7;
  drawTree( numSides,  x * scale,  y* scale,  h* scale,  level + 1);
}

void drawCone(int sides, float r, float h, boolean includeBottom)
{
  float angle = 2 * PI / sides;
  float halfHeight = h / 2;
  noStroke();

  if (includeBottom) {// draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos(i * angle) * r;
      float y = sin(i * angle) * r;
      vertex(x, y, halfHeight);
    }
    endShape(CLOSE);
  }

  // draw sides
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i <= sides ; i++) {
    float x = cos(i * angle) * r;
    float y = sin(i * angle) * r;
    vertex(x, y, halfHeight);
    vertex(0, 0, -halfHeight);
  }
  endShape(CLOSE);
}

