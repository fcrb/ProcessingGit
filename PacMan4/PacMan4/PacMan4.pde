PacMan pacMan;
ArrayList<Food> foods;
int numberOfFoods = 55;
int gridSize = 20;

void setup() {
  size(640, 360);
  pacMan = new PacMan();
  foods = new ArrayList<Food>();
  for (int i = 0; i < numberOfFoods; ++i ) {
    foods.add(new Food());
  }
}

void draw() {
  background(0);
  ArrayList<Food> eatenFoods = new ArrayList<Food>();
  for (Food food : foods) {
    food.draw();
    if (food.eaten) eatenFoods.add(food);
  }
  foods.removeAll(eatenFoods);
  pacMan.draw();
}

int gridify(float offGrid) {
  return round(offGrid/gridSize)*gridSize;
}
class Food {
  float diameter = 10;
  int x, y;
  int clr;
  boolean eaten = false;

  Food() {
    x = gridify(random(0, width));
    y = gridify(random(0, height));
    float r = random(0,255);
    float g = random(0,255);
    float b = random(0,255);
    float maxColor = max(r,max(b,g));
    r *= 255 / maxColor;
    g *= 255 / maxColor;
    b *= 255 / maxColor;
    clr = color(r,g,b);
  }

  void draw() {
    pushMatrix();
    noStroke();
    translate(x, y);
    fill(clr);
    ellipse(0, 0, diameter, diameter);
    popMatrix();
    if(dist(x,y,pacMan.x, pacMan.y) < diameter/2) {
      eaten = true;
    }
  }
}
class PacMan {
  float x = gridify(width/2);
  float y = gridify(height/2);
  float diameter = 40;
  float rotation = 0;
  float stepSize = 1.5;

  void draw() {
    pushMatrix();
    translate(x, y);
    handleKeys();
    rotate(rotation);
    noStroke();
    fill(255,255,0);
    float angle = (1+ sin(millis() * 0.015))*PI/8;
    arc(0, 0, diameter, diameter, angle, 2 * PI - angle);
    popMatrix();
  }

  void handleKeys() {
    if (!keyPressed) {
      return;
    }
    if (key != CODED) {
      return;
    }
    if (keyCode == UP) {
      x = gridify(x);
      rotation = -PI/2;
      y -= stepSize;
    } 
    else if (keyCode == DOWN) {
      x = gridify(x);
      rotation = PI/2;
      y += stepSize;
    } 
    else if (keyCode == LEFT) {
      y = gridify(y);
      rotation = PI;
      x -= stepSize;
    } 
    else if (keyCode == RIGHT) {
       y = gridify(y);
     rotation = 0;
      x += stepSize;
    }
    float radius = diameter/2;
    if(x < -radius) x = width + radius;
    if(x > width + radius) x = - radius;
    if(y < -radius) y = height + radius;
    if(y > height + radius) y = - radius;
  }
}

