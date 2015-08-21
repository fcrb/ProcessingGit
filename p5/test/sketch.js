function setup() {
  createCanvas(320, 240);
}

function draw() {
  rect(0,0,width-1, height-1);
  ellipse(mouseX, mouseY, 10, 10);
}