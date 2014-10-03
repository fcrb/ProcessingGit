void setup() {
  size(800, 800);
  background(255);
  noFill();
  translate(width/2,height/2);
  int numCircles = 30;
  float maxRadius = width / 8;
  float curvatureScalar = 0.12;
  float curveScalar = 3;
  float strokeWtScale = 0.35;
  float separationScale = 1;
  float x = -width/2 * 0.9;
  float y = 0;
  
  for(int i = 1; i <= numCircles; ++i ) {
    float radius = abs(maxRadius * sin((i + 5) * 0.01));
    float dx = radius * separationScale;
    x += dx ;
    y -= curveScalar * curvatureScalar * sin(i * curvatureScalar) * dx ;
    strokeWeight(radius * strokeWtScale);
    ellipse(x, y, 2 * radius, 2 * radius);
  }
}
