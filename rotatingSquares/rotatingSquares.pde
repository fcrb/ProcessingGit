float theta = PI /6;
int n = 6;

void setup() {
  size(640, 640);

  strokeWeight(1);
  rectMode(CENTER);
  translate(width/2, height/2);
  float[] sValues = new float[n];
  float s = width * 0.9;
  stroke(0, 30);
  pushMatrix();
  for (int i = 0; i < n; ++i) {
    sValues[i] = s;
    rect(0, 0, s, s);
    rotate(theta);
    float tanTheta = tan(theta);
    float r = s * tanTheta / (1 + tanTheta);
    s = dist(0, 0, s-r, r);
  }
  popMatrix();

  noFill();
  stroke(255,0,0);
  for (float s_ : sValues) {
    //    sValues.add(s);
//    rect(0, 0, s_, s_);
  }
}
