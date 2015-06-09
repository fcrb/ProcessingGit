float MAX_PIXELS_PER_SECOND = 3;
float ACCELERATION_PER_FRAME = 0.04;
float BRAKE_PER_FRAME = 0.04;
float SERVO_SENSITIVITY = 8;
class Car {
  float x, y, directionRadians, pixelsPerFrame;
  float carLength, carWidth;

  Car() {
    x  = pixelsPerFrame = 0;
    directionRadians = PI / 2;
    carLength = width / 30;
    carWidth = carLength * 0.5;
    y = 0;
  }

  void accelerate() {
    pixelsPerFrame += ACCELERATION_PER_FRAME;
    if (pixelsPerFrame > MAX_PIXELS_PER_SECOND)
      pixelsPerFrame = MAX_PIXELS_PER_SECOND;
  }

  void brake() {
    pixelsPerFrame -= BRAKE_PER_FRAME;
    if (pixelsPerFrame < 0)
      pixelsPerFrame = 0;
  }

  void draw() {
    pushMatrix();
    noStroke();
    fill(255, 0, 0);
    translate(x, y);
    rectMode(CENTER);
    rotate(directionRadians);
    rect(0, 0, carLength, carWidth);

    float dx=carLength * 0.5;
    float dy=carWidth * 0.5;
    boolean offLeft = offTrack(dx, dy);
    boolean offRight = offTrack(dx, -dy);
    float sensorDiameter = 6;
    fill(255, 255, 0);
    if (offLeft || offRight) {
      if (offLeft ) {
        directionRadians -= angleCorrection();
        ellipse(dx, dy, sensorDiameter, sensorDiameter);
        brake();
      }
      //right sensor
      else {
        directionRadians += angleCorrection();
        ellipse(dx, -dy, sensorDiameter, sensorDiameter);
        brake();
      }
    } else {
      accelerate();
    }
    x += pixelsPerFrame * cos(directionRadians);
    y += pixelsPerFrame * sin(directionRadians);
    popMatrix();
  }

  boolean offTrack(float dx, float dy) {
    float cosAngle = cos(directionRadians);
    float sinAngle = sin(directionRadians);
    float dxRotated = dx * cosAngle - dy * sinAngle;
    float dyRotated = dx * sinAngle + dy * cosAngle;
    int trackPixel = get(round( width / 2 - x - dxRotated)
      , round(height/2 + y + dyRotated));
    return trackPixel != TRACK_COLOR;
  }

  float angleCorrection() {
    return 0.01 * SERVO_SENSITIVITY * MAX_PIXELS_PER_SECOND;
  }
}
