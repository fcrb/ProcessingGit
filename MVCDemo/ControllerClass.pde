interface Listener {
  void notifyListener();
}

class Controller implements Listener {
  Model model;
  ArrayList<View> views = new  ArrayList<View>();

  Controller(Model m) {
    model = m;
  }
  
  void addView() {
  }

  void handleInput() {
    if (keyPressed) {
      if (key == '+') {
        model.add(1);
      } else if (key == '-') {
        model.add(-1);
      }
    }
  }

  void notifyListener() {
    requiresRedraw = true;
  }
}
