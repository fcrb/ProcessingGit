class EdgePath {
  ArrayList<EdgeNode> nodes = new  ArrayList<EdgeNode>();

  EdgePath(int x, int y) {
    nodes.add(new EdgeNode(x, y));
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
    int startingNeighbor = 0; 
    if (nodes.size() > 1) {
      EdgeNode previousNode = nodes.get(nodes.size() - 2);
      int dx = x - previousNode.x;
      int dy = y - previousNode.y;
      startingNeighbor = nextNeighborPixelIndex[dx+ZERO_OFFSET][dy+ZERO_OFFSET];
    }

    //loop through neighbors, find nonwhite, unused pixel
    for (int i = 0; i < 7; ++i) {
      NeighborPixel n = neighbors.get((i + startingNeighbor) % 8);
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
