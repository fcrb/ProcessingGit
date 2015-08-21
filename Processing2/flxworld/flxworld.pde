World world;
EventManager eventManager;

void setup() {
  size(640, 360, OPENGL);
  eventManager = new EventManager();
  world = new World();
}

void draw() {
  world.draw();
}

void keyPressed() {
  eventManager.keyPressed();
}

void keyReleased() {
  eventManager.keyReleased();
}
