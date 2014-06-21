class RestartButton {
  float x, y, buttonLength, buttonHeight, textSize, textPadding;
  String restartLabel = "Restart";

  RestartButton(float textSize_) {
    textSize = textSize_;
    textPadding = textSize /4;
    x = (width - buttonLength)/2;
    y= height - spaceBetweenTiles/2 - buttonHeight;
    buttonLength= textWidth(restartLabel) + textPadding * 2;
    buttonHeight = textSize + textPadding * 2;
  }

  void drawButton() {
    //show Restart button in center of bottom of screen
    fill(255);
    rect( x, y, buttonLength, buttonHeight, 5);
    fill(0);
    text(restartLabel, (width - buttonLength)/2 + textPadding, height - spaceBetweenTiles);
  }

  boolean mouseInButton() {
    return mouseX > x && mouseX < x + buttonLength && mouseY > y-buttonHeight && mouseY < y;
  }
}

