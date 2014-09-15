class EdgePath {
  ArrayList<EdgeNode> nodes = new  ArrayList<EdgeNode>();

  EdgePath(int x, int y) {
    nodes.add(new EdgeNode(x, y));
  }

  void draw(float scale) {
    for (int i = 1; i < nodes.size(); ++i) {
      EdgeNode n1 = nodes.get(i-1);
      EdgeNode n2 = nodes.get(i);
      line(n1.x * scale, n1.y * scale, n2.x * scale, n2.y * scale);
    }
  }

  void draw(float scale, PGraphics pdf) {
    for (int i = 1; i < nodes.size(); ++i) {
      EdgeNode n1 = nodes.get(i-1);
      EdgeNode n2 = nodes.get(i);
      pdf.line(n1.x * scale, n1.y * scale, n2.x * scale, n2.y * scale);
    }
  }

  void populatePath(boolean[][] onEdge, boolean[][] onAPath) {
    while (findNextNode (onEdge, onAPath) != null) {
    };
  }

  EdgeNode findNextNode( boolean[][] onEdge, boolean[][] onAPath) {
    //returns null if there is no next node
    EdgeNode currentNode = nodes.get(nodes.size() - 1);
    int x = currentNode.x;
    int y = currentNode.y;

    //loop through neighbors, find nonwhite, unused pixel
    for ( NeighborPixel n : neighbors) {
      //      NeighborPixel n = neighbors.get((i + startingNeighbor) % 8);
      int xNbr = x + n.dx;
      int yNbr = y + n.dy;
      if (onEdge[xNbr][yNbr] && !onAPath[xNbr][yNbr]) {
        EdgeNode newEdgeNode = new EdgeNode(xNbr, yNbr);
        onAPath[xNbr][yNbr] = true;
        nodes.add(newEdgeNode);
        EdgeNode firstNode = nodes.get(0);
        if (xNbr == firstNode.x && yNbr == firstNode.y) {
          //we've looped, so report there is no next node
          return null;
        }
        return newEdgeNode;
      }
    }
    //hmmm. We looked, and could not find a new node. It seems this
    //might happen if two regions just touch at a point or two.
    return null;
  }
}

