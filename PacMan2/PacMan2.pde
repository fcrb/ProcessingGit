PacMan bob;
Food food;

void setup() {
  size(640, 360);
  bob = new PacMan();
  food = new Food();
}

void draw() {
  bob.draw();
  food.draw();
}
