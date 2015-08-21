Cilia c1;
Cilia c2;
Cilia c3;
Cilia c4;

class Cilia {
  int numSegments = 40;
  float firstSegmentLength;;
  float endpointX[] = new float[numSegments+1];
  float endpointY[] = new float[numSegments+1];
  
  public Cilia(int x, int y) {
    firstSegmentLength = dist(0,0, width, height) / numSegments * 0.5;
    endpointX[0] = x;
    endpointY[0] = y;
    for(int i = 1; i <= numSegments; ++i) {
      endpointX[i] =  endpointX[i-1] + segmentLength(i);
      endpointY[i] = y;
    }
  }
  
  public void draw() {
      float strokeWeight = 10;
  for(int i = 1; i <= numSegments; ++i) {
    float easeWeightOnMouse = 0.02 * i * i / numSegments /numSegments ;
    float newX = endpointX[i] + (mouseX - endpointX[i] ) * easeWeightOnMouse;
    float newY = endpointY[i] + (mouseY - endpointY[i] ) * easeWeightOnMouse;
    float distToNewPoint = dist(endpointX[i-1], endpointY[i-1], newX, newY);
    float segmentLength = segmentLength(i);
    float deltaScalar =  1;
    if(segmentLength < distToNewPoint)
      deltaScalar =  segmentLength / distToNewPoint;
    endpointX[i] = endpointX[i-1] + (newX - endpointX[i-1]) * deltaScalar;
    endpointY[i] = endpointY[i-1] + (newY - endpointY[i-1]) * deltaScalar;
    strokeWeight *= 0.95;
    strokeWeight(strokeWeight);
    line(endpointX[i-1], endpointY[i-1], endpointX[i], endpointY[i]);
  }
    strokeWeight(2);
    ellipse(endpointX[numSegments], endpointY[numSegments],10,10);
  }
  
  float segmentLength(int index) {
    return firstSegmentLength;
   }

}
 

void setup() {
  size(480,360);
//  frameRate(10);
  c1 = new Cilia(0,0);
  c2 = new Cilia(width, height);
  c3 = new Cilia(width,0);
  c4 = new Cilia(0, height);
}

void draw() {
  background(200);
  //Drawing a cilia consisting of segments. These segments
  //could be fixed length, or decreasing. They could be drawn
  //with lines, or just draw the endpoints. Segments
  //are index with 0 being the base, and numSegments -1 being 
  //the tip.
  
  //Use easing with each segment. The amount of easing
  //could be based on index, or distance of the segment 
  //from the mouse pointer.
  
  //Start with drawing circles at the endpoints, easing based
  //on index. 
  //  ellipse(endpointX[0], endpointY[0], 10, 10);
  c1.draw();
  c2.draw();
  c3.draw();
  c4.draw();
}

