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
