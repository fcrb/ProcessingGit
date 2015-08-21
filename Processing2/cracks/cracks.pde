ArrayList<Crack> cracks;
void setup() {
  size(480,480);
  cracks = new ArrayList<Crack>();
  cracks.add(new Crack(width/2, height/2, random(2*PI)));
}

void draw() {
  for(Crack crack: cracks) {
    crack.propagate(cracks);
    
  }
}

class Crack {
  float x, y, direction;
  
  Crack(float x_, float y_, float direction_) {
    x = x_;
    y=y_;
    direction = direction_;
  }
}
  
  
