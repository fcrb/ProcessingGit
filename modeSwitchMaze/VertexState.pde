class VertexState {
  Vertex v;
  int mode;
  
  VertexState(Vertex v_, int mode_) {
    v = v_;
    mode = mode_;
  }
  
  boolean equals(Object obj) {
    if(obj == null) return false;
    VertexState vs = (VertexState) obj;
    return vs != null && v == vs.v && mode == vs.mode;
  }
 
  String displayString() {
    return "("+v.x +','+v.y+','+mode+')';
  }

}
