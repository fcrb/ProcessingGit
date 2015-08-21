class View {
  boolean requiresRedraw = true;

  void draw() {
    if (!requiresRedraw) { 
      return;
    }
    //we  update the view here
    background(255);
    String message = "" + model.getCounter();
    float txtSize = width/4;
    textSize(txtSize);
    fill(0);
    text(message, (width - textWidth(message))/2, height/2);
    requiresRedraw = false;
  }

  void modelChanged() {
    requiresRedraw = true;
  }
}
