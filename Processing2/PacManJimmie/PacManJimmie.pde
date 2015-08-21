PacMan pacMan;
ArrayList<Food> foods;
int numberOfFoods = 3;

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
  for (Food food : foods) {
    food.draw();
  }
  pacMan.draw();
}

