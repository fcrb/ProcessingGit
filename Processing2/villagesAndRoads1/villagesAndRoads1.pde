Village[] villages;
ArrayList<Junction> junctions;
ArrayList<Road> roads;
int villageRadius = 30;
int junctionRadius = villageRadius / 2;

void setup() {
  size(240,240);
  int numVillages = 4;
  villages = new Village[numVillages];
  for(int i = 0; i < villages.length; ++i) {
    float angle = 2 * PI * i / numVillages;
    villages[i] = new Village((width + Math.cos(angle)* (width - villageRadius))/2, (height + Math.sin(angle)* (height- villageRadius))/2);
  }
  junctions = new ArrayList<Junction>();
  roads = new ArrayList<Road>();
}

void draw() {
  background(50);
   for(int i = 0; i < villages.length; ++i)
     villages[i].draw();
   for(Junction j : junctions)
     j.draw();
   for(Road r : roads)
     r.draw();
}

void mousePressed(MouseEvent e) {
  if (e.getClickCount()==2)
    println("<double click>");
  boolean mouseEventHandled = false;
  for(int i = 0; i < villages.length; ++i) {
    Village v = villages[i];
    if(v.hasMousePointer()) {
      v.handleMouseEvent(e);
      mouseEventHandled = true;
    }
  }
  if(!mouseEventHandled) {
    Junction j = new Junction(mouseX, mouseY);
    junctions.add(j);
    roads.add(new Road(j, null));
  }
}

interface Node {
  float getX();
  float getY();
  float getRadius();
}

class Village implements Node {
  float x;
  float y;
  
  Village(double x_, double y_) {
    x = (float) x_;
    y = (float) y_;
  }
  
  void draw () {
    fill(255);
    ellipse(x, y, villageRadius, villageRadius);
  }
  
  boolean hasMousePointer() {
    return dist(x,y,mouseX, mouseY) <= villageRadius;
  }
  
  void handleMouseEvent(MouseEvent e) {
    println(e);
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  float getRadius() {
    return villageRadius;
  }
}

class Junction implements Node {
  float x;
  float y;
  
  Junction(double x_, double y_) {
    x = (float) x_;
    y = (float) y_;
  }
  
  void draw () {
    fill(50);
    ellipse(x, y, junctionRadius, junctionRadius);
  }
  
  float getRadius() {
    return junctionRadius;
  }

  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
}

class Road {
  Node from;
  Node to;
  
  Road(Node from_, Node to_) {
    from = from_;
    to=to_;
  }
  
  void draw() {
    float targetX;
    if (to == null) targetX =  mouseX;
    else targetX = to.getX();
    float targetY;
    if (to == null) targetY =  mouseY;
    else targetY = to.getY();
    line(from.getX(), from.getY(), targetX, targetY);
  }

}
  
