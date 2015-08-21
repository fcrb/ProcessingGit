Cilia[] leeches;

void setup() {
  size(480, 480);
  //  frameRate(10);
  ellipse(10, 10, 40, 40);
  int perimeter = (width + height) * 2;
  leeches = new Cilia[50];
  for (int i = 0; i < leeches.length; ++i) {
    //leeches[i] = new Cilia((int)random(width), (int) random(height));
    int distAlongPerimeter = i * perimeter / leeches.length;
    if ( distAlongPerimeter < width)
      leeches[i] = new Cilia(distAlongPerimeter, 0);
    else if ( distAlongPerimeter < width + height)
      leeches[i] = new Cilia(width, distAlongPerimeter - width);
    else if ( distAlongPerimeter < 2 * width + height)
      leeches[i] = new Cilia(2 * width - distAlongPerimeter + height, height);
    else leeches[i] = new Cilia(0, 2 * height - distAlongPerimeter + 2 * width);
  }
}

void draw() {
  background(200);
  for (int i = 0; i < leeches.length; ++i)
    leeches[i].draw();
}

class Cilia {
  int numSegments = 30;
  float segmentLength;
  float endpointX[];
  float endpointY[];

  public Cilia(int x, int y) {
    endpointX = new float[numSegments+1];
    endpointY = new float[numSegments+1];
    segmentLength = dist(0, 0, width, height) / numSegments * 0.6;
    endpointX[0] = x;
    endpointY[0] = y;
    for (int i = 1; i <= numSegments; ++i) {
      endpointX[i] =  endpointX[i-1] + segmentLength;
      endpointY[i] = y;
    }
  }

  public void draw() {
    //Drawing a leeches consisting of segments. These segments
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
   float segmentWidth = 10;
    for (int i = 1; i <= numSegments; ++i) {
      float easeWeightOnMouse = 0.02 * i * i / numSegments /numSegments ;
      float newX = endpointX[i] + (mouseX - endpointX[i] ) * easeWeightOnMouse;
      float newY = endpointY[i] + (mouseY - endpointY[i] ) * easeWeightOnMouse;
      float distToNewPoint = dist(endpointX[i-1], endpointY[i-1], newX, newY);
      //float segmentLength = segmentLength(i);
      float deltaScalar =  1;
      if (segmentLength < distToNewPoint)
        deltaScalar =  segmentLength / distToNewPoint;
      endpointX[i] = endpointX[i-1] + (newX - endpointX[i-1]) * deltaScalar;
      endpointY[i] = endpointY[i-1] + (newY - endpointY[i-1]) * deltaScalar;
      segmentWidth *= 0.9;
      strokeWeight(segmentWidth);
      line(endpointX[i-1], endpointY[i-1], endpointX[i], endpointY[i]);
    }
    strokeWeight(2);
    //ellipse(endpointX[numSegments], endpointY[numSegments], 10, 10);
  }

  //  float segmentLength(int index) {
  //    return firstSegmentLength;
  //  }
}


