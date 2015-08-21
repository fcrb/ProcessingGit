class Model {
  int counter = 0;
  ArrayList<Listener> listeners = new ArrayList<Listener>();

  void addListener(Listener listener) {
    listeners.add(listener);
  }

  void add(int numToAdd) {
    counter += numToAdd;
    for (Listener listener : listeners) {
      listener.notifyListener();
    }
  }

  int getCounter() {
    return counter;
  }
}
