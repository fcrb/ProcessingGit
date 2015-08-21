void setup() {
  size(640, 640);
  background(255);
  translate(width/2, height/2);
  
 float radius = width/2 * 0.3;
 //unit circle
 ellipse(0,0,radius * 2, radius * 2);
 
 //tangent line
 line(radius, -radius*2, radius, radius * 2);
 
 //circle ticks
}
