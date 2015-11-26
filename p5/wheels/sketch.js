var wheel;
var deltaTime = 0.001;
var time = 0;
var stepsPerFrame = 50;
var MAX_PEN_WIDTH = 15;
var fixedPenWidth = false;

function setup() {
  createCanvas(800, 800);
  wheel = new Wheel(width * 0.2, 3, color(0, 255, 0));
  wheel.setSubwheel(new Wheel(width * 0.15, -4, color(0, 255, 0)));
  // wheel.setSubwheel(new Wheel(width * 0.02, 2.0/3, color(0, 255, 0)));
  // wheel.setSubwheel(new Wheel(width * 0.025, 48, color(0, 255, 0)));
  background(0);
}

function draw() {
  translate(width / 2, height / 2);
  scale(1, -1);
  for (var step = 0; step < stepsPerFrame; ++step) {
    time += deltaTime;
    wheel.drawCenteredAt(0, 0);
  }
}