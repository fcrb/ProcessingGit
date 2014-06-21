class Path {
  /*
  A path is equivalent to a sequence of vertices. It knows 
   the current mode (the mode of the last modeSegment it passed
   through).
   */
  ArrayList<VertexState> vertexStates = new ArrayList<VertexState>();

  Path(ArrayList<VertexState> oldVertexStates ) {
    vertexStates.addAll(oldVertexStates);
  }

  Path(Segment startingSegment) {
    if (startingSegment==null) {
      println("null in Path() ctor");
    }
    vertexStates.add(new VertexState(startingSegment.v1, -1));
    vertexStates.add(new VertexState(startingSegment.v2, startingSegment.newMode(-1)));
  }

  int currentMode() {
    return lastVertexState().mode;
  }

  void addSegment(Segment segment) {
    Vertex vertex = (lastVertexState().v == segment.v1) ? segment.v2 : segment.v1;
    int newMode = segment.newMode(currentMode());
    if (vertex != null) vertexStates.add(new VertexState(vertex, newMode));
  }

  Path copy() {
    return new Path(vertexStates);
  }

  String displayString() {
    String result = "length = "+length() + ": ";
    for (VertexState vs : vertexStates) {
      if (vs==null) {
        println("null in Path.displayString");
      }  
      else
      { 
        result = result  + " " + vs.displayString();
      }
    }
    return result;
  }

  boolean includesSegment(Segment s) {
    for (int i = 1; i < length(); ++i) {
      if (s.contains(vertexStates.get(i-1).v) && s.contains(vertexStates.get(i).v) ) {
        return true;
      }
    }
    return false;
  }

  VertexState lastVertexState() {
    return vertexStates.get(vertexStates.size() - 1);
  }

  int indexOfVertexState(VertexState vs) {
    for (int i = 0; i < vertexStates.size(); i++) {
      if (vertexStates.get(i).equals(vs)) {
        return i;
      }
    }
    return -1;
  }

  int length() {
    return vertexStates.size();
  }

  VertexState previousVertexState() {
    if (vertexStates.size() < 2) return null;
    return vertexStates.get(vertexStates.size() - 2);
  }

  boolean isFinished() {
    //If the last vertexState added has already been seen, 
    //stop because we have started a loop
    for (int i = 0; i < vertexStates.size() - 1; i++) {
      if (vertexStates.get(i).equals(lastVertexState())) {
        return true;
      }
    }
    return false;
  }
}
