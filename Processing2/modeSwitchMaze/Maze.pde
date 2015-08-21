class Maze { //<>//
  ArrayList<Vertex> vertices; 
  ArrayList<Segment> segments; 
  //  Vertex startVertex;
  Vertex endVertex;
  ArrayList<Path> paths;

  Maze() {
    vertices = new ArrayList<Vertex>();
    segments = new ArrayList<Segment>();
  }

  Vertex getVertex(int x, int y) {
    for (Vertex vertex : vertices) {
      if (vertex.x == x && vertex.y == y)
        return vertex;
    }
    Vertex newVertex = new Vertex(x, y);
    vertices.add(newVertex);
    return newVertex;
  }

  Segment addSegment(int x1, int y1, int x2, int y2) {
    Segment seg = new Segment(getVertex(x1, y1), getVertex(x2, y2));
    segments.add(seg);
    return seg;
  }

  Segment addModeSegment(int x1, int y1, int x2, int y2, int mode) {
    Segment seg = new ModeSegment(getVertex(x1, y1), getVertex(x2, y2), mode);
    segments.add(seg);
    return seg;
  }

  void draw() {
    background(255);
    Path solution = shortestSolution();
    if (solution == null) {
      println("no solution");
    } 
    else {
      for (Segment segment : segments) {
        if (solution.includesSegment(segment)) {
          stroke(255, 0, 0);
        } 
        else {
          stroke(0);
        }
        segment.draw();
      }
    }
  }

  void setEndVertex(int x_, int y_) {
    endVertex = getVertex(x_, y_);
  }

  Path shortestSolution() {
    solve();
    println("# paths = " + paths.size());
    int minSolutionLength = 1000;
    Path minSolution = null;
    for (Path path: paths) {
      if (path.lastVertexState().v == endVertex) {
        if (path.length() < minSolutionLength) {
          minSolutionLength = path.length();
          minSolution = path;
        }
      }
    }
    return minSolution;
  }

  void solve() {
    if (paths != null) return;
    paths = new ArrayList<Path>();
    Path newPath = new Path(segments.get(0));
    paths.add(newPath);
    findPaths(newPath);
  }
  void findPaths(Path path) {
    if (paths.size() > 100000) return;
    if (path.isFinished() ) return;
    VertexState currentVertexState = path.lastVertexState();
    VertexState previousVertexState = path.previousVertexState();
    ArrayList<Segment> nextSegments = segmentsFrom(currentVertexState.v);
    boolean pathsAdded = false;
    for (Segment segment : nextSegments) {
      if (previousVertexState == null || !segment.contains( previousVertexState.v)) {
        if (segment.canAddToPath(path)) {
          Path newPath = path.copy();
          newPath.addSegment(segment);
          paths.add(newPath);
          findPaths(newPath);
          pathsAdded = true;
        }
      }
    }
    if (pathsAdded) {
      //this path was extended, so don't need to keep it.
      paths.remove(path );
    }
  }

  ArrayList<Segment> segmentsFrom(Vertex vertex) {
    ArrayList<Segment> nextSegments = new ArrayList<Segment>();
    for (Segment segment : segments) {
      if (segment.contains(vertex))
        nextSegments.add(segment);
    }
    return nextSegments;
  }

  ArrayList<Vertex> verticesFrom(Vertex vertex) {
    ArrayList<Vertex> nextVertices = new ArrayList<Vertex>();
    for (Segment segment : segments) {
      if (segment.contains(vertex))
        nextVertices.add(vertex);
    }
    return nextVertices;
  }
}