class World {
  ArrayList<Block> blocks;
  float side = height/2;
  float halfSide = height/4;

  World() {
    destroy();
    
    
  }
  
  float bounce(float d, float vd) {
    if (d < -halfSide) return abs(vd);
    if (d > halfSide) return -abs(vd);
    return vd;
  }

  void destroy() {
    blocks = new ArrayList<Block>();
  }

  void draw() {
    background(255);
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

    for (Block block: blocks) {
      block.draw();
    }
    //draw box frame
    noFill();
    stroke(100, 100);
    strokeWeight(1);
    box(side, side, side);
  }
}
