import processing.opengl.*;


void setup()
{
  size(450, 450, OPENGL);
}

void draw()
{
  background(255);
  lights();

  fill(255, 255, 0);

  pushMatrix();    
  translate( width/2, height/2, 0 );
  rotateX( 0.8376482 * radians( frameCount )  );
  rotateY( radians( frameCount ) );
  rotateZ( radians( 1.1234*frameCount ) );
  drawCylinder( 30, 25, 250, false);
  popMatrix();
}

void drawCylinder( int sides, float r, 
  float x1, float y1, float z1,  
  float x2, float y2, float z2, boolean drawEnds) {
    translate(x1, y1, z1);
    float h = dist(x1, y1, z1, x2, y2, z2);
    
}

void drawCylinder( int sides, float r, float h, boolean drawEnds)
{
  float angle = 360 / sides;
  float halfHeight = h / 2;

  // draw top of the tube
  if (drawEnds) {  
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
  }

  // draw sides
  noStroke();
  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, halfHeight);
    vertex( x, y, -halfHeight);
  }
  endShape(CLOSE);
}
