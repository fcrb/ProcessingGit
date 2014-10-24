class EdgePath {
  ArrayList<EdgeNode> nodes = new  ArrayList<EdgeNode>();

  EdgePath(int x, int y) {
    nodes.add(new EdgeNode(x, y));
  }

  void draw(float scale) {
//    for (int i = 1; i < nodes.size(); ++i) {
//      EdgeNode n1 = nodes.get(i-1);
//      EdgeNode n2 = nodes.get(i);
//      line(n1.x * scale, n1.y * scale, n2.x * scale, n2.y * scale);
//    }
    beginShape();
    for(EdgeNode node : nodes) {
      vertex(node.x * scale, node.y * scale);
    }
    endShape();
  }

  void draw(float scale, PGraphics pdf) {
//    for (int i = 1; i < nodes.size(); ++i) {
//      EdgeNode n1 = nodes.get(i-1);
//      EdgeNode n2 = nodes.get(i);
//      pdf.line(n1.x * scale, n1.y * scale, n2.x * scale, n2.y * scale);
//    }
    pdf.beginShape();
    for(EdgeNode node : nodes) {
      pdf.vertex(node.x * scale, node.y * scale);
    }
    pdf.endShape();
  }

  void populatePath(boolean[][] onEdge, boolean[][] onAPath) {
    while (findNextNode (onEdge, onAPath) != null) {
    };
  }

  void reducePath(float maxErrorFromLine) {
    ArrayList<EdgeNode> nodesToRemoveFromPath = new ArrayList<EdgeNode>();
    int indexOfFirstNodeInShortcut = 0;
    int indexOfLastNodeInShortcut = indexOfFirstNodeInShortcut + 2;
    //follow the path, creating shortened segments by removing unneeded EdgeNodes 
    while (indexOfLastNodeInShortcut < nodes.size () ) {
      EdgeNode firstNodeInShortcut = nodes.get(indexOfFirstNodeInShortcut);
      EdgeNode lastNodeInShortcut = nodes.get(indexOfLastNodeInShortcut);
      Vec2D shortCut = new Vec2D(lastNodeInShortcut.x - firstNodeInShortcut.x, lastNodeInShortcut.y - firstNodeInShortcut.y);
//      println("reducePath() shortCut="+shortCut);
      //what's the maximum error?
      float error = 0;
      for (int i = indexOfFirstNodeInShortcut + 1; i < indexOfLastNodeInShortcut; ++i) {
        EdgeNode nodeToProject = nodes.get(i);
        Vec2D vecToProject = new Vec2D(nodeToProject.x - firstNodeInShortcut.x, nodeToProject.y - firstNodeInShortcut.y);
        error = max(error, vecToProject.distanceFromProjectionOnto(shortCut));
//       if( error > maxErrorFromLine ) {
//      println("reducePath() shortCut="+shortCut);
//      println("reducePath() vecToProject="+vecToProject);
//       }
      }
      if (error > maxErrorFromLine || indexOfLastNodeInShortcut == nodes.size() - 1 ) {
        //went a step too far
        --indexOfLastNodeInShortcut;
        for (int i = indexOfFirstNodeInShortcut + 1; i < indexOfLastNodeInShortcut; ++i) {
          EdgeNode nodeToRemove = nodes.get(i);
          nodesToRemoveFromPath.add(nodeToRemove);
        }
        indexOfFirstNodeInShortcut = indexOfLastNodeInShortcut;
        indexOfLastNodeInShortcut = indexOfFirstNodeInShortcut + 2;
      } 
      else {
        ++indexOfLastNodeInShortcut;
      }
    }
    nodes.removeAll(nodesToRemoveFromPath);
  }


  void reducePathOLD(PGraphics pdf) {
    //    ArrayList<EdgeNode> nodesToRemove = new ArrayList<EdgeNode>();
    //    int lastKeptNodeIndex = 0;
    //    int stepsBetweenNodes = 10;
    //    EdgeNode startNode = nodes.get(lastKeptNodeIndex);
    //    EdgeNode endNode = nodes.get(lastKeptNodeIndex + stepsBetweenNodes);
    //    Vec2D newVec = new Vec2D(endNode.x - startNode.x, endNode.y - startNode.y);
    //    float newVecLength = newVec.length();
    //    float totalDisplacement = 0;
    //    for (int i = lastKeptNodeIndex+1; i < lastKeptNodeIndex + stepsBetweenNodes; ++i) {
    //      EdgeNode node = nodes.get(i);
    //      Vec2D vecToNode = new Vec2D(node.x - startNode.x, node.y - startNode.y);
    //displacement is sin(angle between) * length(vecToNode), and 
    //cos angle between is inner product divided by lengths of vecToNode
    //      float cosAngleBetween = newVec.innerProduct(vecToNode) / vecToNode.length() / newVecLength;
    //      float sinAngleBetween = sqrt(1 - cosAngleBetween * cosAngleBetween);
    //      float displacement = sinAngleBetween *  vecToNode.length();
    //      totalDisplacement += displacement;
    //    }
    //    for (int i = 1; i < nodes.size(); ++i) {
    //      EdgeNode n = nodes.get(i);
    //      pdf.line(n1.x * scale, n1.y * scale, n2.x * scale, n2.y * scale);
    //    }
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
