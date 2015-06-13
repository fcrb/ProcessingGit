int TRACK_COLOR = color(0);
class Track {
  PGraphics cleanImage;
  /*
  Plan is to use cleanImage for use by sensors. Another
  image (pathImage) will show where the car has been, and 
  will be the image that is actually displayed.
  */

  Track() {
    cleanImage = createGraphics(width, height);
    cleanImage.beginDraw();
    cleanImage.stroke(TRACK_COLOR);
    cleanImage.strokeWeight(width * 0.05);
    cleanImage.noFill();
    cleanImage.translate(width/2, height/2);
    drawThreeOvals();
    cleanImage.endDraw();
  }

  void draw() {
    image(cleanImage, 0, 0);
  }

  void drawThreeOvals() {
    float loopWidth = width * 0.45;
    cleanImage.ellipse(-loopWidth *0.5, 0, loopWidth, height * 0.8);
    cleanImage.ellipse(loopWidth * 0.5, 0, loopWidth, height * 0.8);
    //    ellipse(0, 0, loopWidth, height * 0.8);
  }
}
