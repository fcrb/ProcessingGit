Controller controller;

void setup() {
  size(200, 150);
  Model model = new Model();
  controller = new Controller(model);
  model.addListener(controller);
  View view = new View();
  controller.addView(view);
}

void draw() {
  //Since draw is being called frequently, it acts as our
  //event loop
  controller.handleInput();
}
