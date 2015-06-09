float MAX_PIXELS_PER_SECOND = 3;
float ACCELERATION_SECOND = 0.02;
class Car {
  float x, y, directionRadians, pixelsPerSecond;
  int carLength, carWidth;
  boolean stopped = false;

  Car() {
    x = directionRadians = pixelsPerSecond = 0;
    carLength = width / 20;
    carWidth = height / 30;
    y = height * 0.4;
  }

  void accelerate() {
    if (pixelsPerSecond < MAX_PIXELS_PER_SECOND && !stopped)
      pixelsPerSecond += ACCELERATION_SECOND;
  }

  void draw() {
    pushMatrix();
    noStroke();
    fill(255, 0, 0);
    translate(x, y);
    rectMode(CENTER);
    rotate(directionRadians);
    rect(0, 0, carLength, carWidth);


    boolean offLeft = offTrack(carLength * 0.5, carWidth * 0.5);
    boolean offRight = offTrack(carLength * 0.5, -carWidth * 0.5);
    //off the track
//    if (offLeft && offRight) {
//      pixelsPerSecond = 0;
//      stopped = true;
//    } 
//    //left sensor
//    else 
    if (offLeft) {
      directionRadians -= angleCorrection();
    }
    //right sensor
    else if (offTrack(carLength * 0.5, -carWidth * 0.5)) {
      directionRadians += angleCorrection();
    }

    x += pixelsPerSecond * cos(directionRadians);
    y += pixelsPerSecond * sin(directionRadians);
    popMatrix();
  }

  boolean offTrack(float dx, float dy) {
    float cosAngle = cos(directionRadians);
    float sinAngle = sin(directionRadians);
    float dxRotated = dx * cosAngle - dy * sinAngle;
    float dyRotated = dx * sinAngle + dy * cosAngle;
    int trackPixel = get(round(width/2 + x + dxRotated), round(height/2+ y + dyRotated));
    return trackPixel != TRACK_COLOR;
  }

  float angleCorrection() {
    return 0.03 * MAX_PIXELS_PER_SECOND;
  }
}
