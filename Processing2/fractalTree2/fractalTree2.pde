private static final long serialVersionUID = 1509046558596451983L;
private float rotation = PI / 16;
private float scaleDown = 0.9f;
private int maxLevel = 11;

//public static void main(String[] args) {
//  PApplet.main(new String[] { 
//    "--present", 
//    "org.mrbenson.fractaltree.FractalTreeSketch"
//  }
//  );
//}

public void setup() {
  size(640, 550);
}

public void draw() {
  background(255, 255, 150);
  fill(0);
  textSize(18);
  text("fps = " + (int) (frameCount * 1000.0f / millis()), 20, 20);
  drawTree(width * 0.5f, height * 0.95f, width * 0.5f, height * 0.83f, 0);
}

private void drawTree(float x1, float y1, float x2, float y2, int level) {
  if (level > maxLevel) {
    return;
  }
  // draw the trunk of the tree
  stroke(level * level * 255.0f / maxLevel / maxLevel, 0, 0);
  strokeWeight(maxLevel - level + 1);
  line(x1, y1, x2, y2);

  // create two branches, each of which is another tree (recursion!)
  float angleScale = 2.0f * mouseY / height;
  float angleShift = (mouseX - width * 0.5f) / width * rotation;
  float angle = (rotation + angleShift) * angleScale;
  float cosR = cos(angle);
  float sinR = sin(angle);
  drawTree(x2, y2, 
  x2 + scaleDown * (cosR * (x2 - x1) - sinR * (y2 - y1)), y2
    + scaleDown * (sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1);
  angle = (rotation - angleShift) * angleScale;
  cosR = cos(angle);
  sinR = sin(angle);
  drawTree(x2, y2, 
  x2 + scaleDown * (cosR * (x2 - x1) + sinR * (y2 - y1)), y2
    + scaleDown * (-sinR * (x2 - x1) + cosR * (y2 - y1)), 
  level + 1);
}

