int numSegments = 40;
float firstSegmentLength;;
float endpointX[] = new float[numSegments+1];
float endpointY[] = new float[numSegments+1];

void setup() {
  size(480,360);
//  frameRate(10);
  float firstSegmentLength = dist(0,0,width, height) / numSegments * 0.5;
  endpointX[0] = 0;
  endpointY[0] = 0;
  for(int i = 1; i <= numSegments; ++i) {
    endpointX[i] =  endpointX[i-1] + segmentLength(i);
    endpointY[0] = 0;
  }
}

void draw() {
  background(100);
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
  float strokeWeight = 20;
  for(int i = 1; i <= numSegments; ++i) {
    float easeWeightOnMouse = 0.03 * i * i / numSegments /numSegments ;
    float newX = easeWeightOnMouse * mouseX + endpointX[i] * (1-easeWeightOnMouse);
    float newY = easeWeightOnMouse * mouseY +  endpointY[i]* (1-easeWeightOnMouse);
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
}

float segmentLength(int index) {
  return firstSegmentLength;
}
