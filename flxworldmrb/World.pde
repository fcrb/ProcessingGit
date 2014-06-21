class World {
  ArrayList<Visible> visibles;
  float x, y, z;
  float heading = 0;
  float stepSize = 10;
  float headingStep = 0.04;

  World() {
    x = y = z = 0;
    visibles = new ArrayList<Visible>();
    float blockSize = width / 6;
    visibles.add(new Cone(width*2, 0, 0, 20, blockSize * 3, 10 * blockSize, false, color(255, 255, 0)));
    float blockSpacing = blockSize * 2;
    for (int i = 2; i < 11; ++i) {
      visibles.add(new Block(blockSpacing * i, 0, 0, blockSize, blockSize, blockSize, color(255, 0, 0)));
      visibles.add(new Block(-blockSpacing * i, 0, 0, blockSize, blockSize, blockSize, color(255, 200, 200)));
      visibles.add(new Block(0, 0, blockSpacing * i, blockSize, blockSize, blockSize, color(0, 0, 255)));
      visibles.add(new Block(0, 0, -blockSpacing * i, blockSize, blockSize, blockSize, color(200, 200, 255)));
    }
    int numSpheres = 12;
    float radius = width * 2;
    for (int i = 0; i < numSpheres; ++i) {
      float angle = i * 2 * PI / numSpheres;
      visibles.add(new Sphere(radius * cos(angle), 0, radius * sin(angle), blockSize
        , color(127 * (1 + cos(angle)), 127 * (1 + sin(angle)), 127)));
    }
  }

  void draw() {
    handleInput();
    //draw sky
    background(160, 160, 250);
    lights();

    //draw floor
    pushMatrix();
     translate(0, 240-y, 0);
   fill(color(0,255,0));
    rotateX(PI/2);
    rectMode(CENTER);
    fill(150, 250, 150);
    rect(0, 0, 10000, 10000);
     translate(0, y+240, 0);
   popMatrix();

    //draw visibles
    translate(width/2, height/2, 0);
    rotateY(heading);
    float pixelsBelowEyeLevel = 60;
    camera(x, y - pixelsBelowEyeLevel, z, x - cos(heading), y - pixelsBelowEyeLevel, z - sin(heading), 0.0, 1.0, 0.0);
    for (Visible visible : visibles) {
      visible.draw();
    }
  }

  void handleInput() {
    //forward
    if (eventManager.hasKey('w') ) {
      x -= stepSize * cos(heading);
      z -= stepSize * sin(heading);
    } 
    //backward
    if (eventManager.hasKey('s') ) {
      x += stepSize * cos(heading);
      z += stepSize * sin(heading);
    }
    //turn left
    if (eventManager.hasKey('a') ) {
      heading -= headingStep ;
    }
    //turn right
    if (eventManager.hasKey('d') ) {
      heading += headingStep;
    }
    //ascend
    if (eventManager.hasKey(' ') ) {
      y -= stepSize;
    } 
    //fall
    else if (y < 0) {
      y  += stepSize;
    }
  }
}
