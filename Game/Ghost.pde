class Ghost extends character{
  PImage ghostImg; 
  int MODE = 0;
  int SCATTER = 1; // spreads out to the corners 
  int CHASE = 2 ; // chase Pacman
  int RETURNING = 3; // return to base after being eaten
  
  chaseFrontier PATH; 
  boolean found = false; 
  
  boolean vulnerable = false;
  int blueTime = 0; 
  PImage blueghost; 
  PImage eyesghost;
  
  Node target;
  Node VulMove;
  chaseFrontier chaser = new chaseFrontier(); 
  
  // ArrayList<Node> ghostNodes; 
  // pac targetChar; 
  
  Ghost(Node start, Node target, PImage img, ArrayList<Node> nodeArrays){
     super(start, img);
     ghostImg = icon = img; 
     this.target = target; 
     MODE = SCATTER;
     // ghostNodes = nodeArrays;
     
     speed = 1.5; 
     // vulnearbleimg = loadImage("VulnerableGhost.png");
  }
 

  private float distanceToTarget(Node node) {
      float dx = node.row - target.row;
      float dy = node.col - target.col;
      return (float) Math.sqrt(dx * dx + dy * dy);
  }

  Node oldPickNextMove(boolean run) {
      //run = true, means you are running away from your target
      //run = false means you are running towards your target
      Node bestNext = null;
      float bestDist;
      if (run) bestDist = Float.MAX_VALUE ;
      else bestDist =Float.MIN_VALUE;
      
      for (Node neighbor : currNode.getNeighbors()) {
          if (neighbor == prevNode) continue;
          
          float dist = distanceToTarget(neighbor);
          if ((run && dist < bestDist) || (!run && dist > bestDist)) {
              bestNext = neighbor;
              bestDist = dist;
          }
      }
      return bestNext;
  }
  
  Node pickNextMove(boolean run){ // run is true when the ghost is in blue state
    ArrayList<Node> path = selectBestPath(); 
    if (path != null && path.size() > 0 && !run){
    //  System.out.println( " the nonvuln is running");
      System.out.println("Path: " + path); 
      return path.remove(0); 
    }
    // if there is no best path, it should return a random one); 
    else if(currNode == nodeGrid[10][10]) return nodeGrid[10][9];
    else if(VulMove != null && currNode != VulMove) return VulMove;
    else {
      ArrayList<Node> neighbors = currNode.getNeighbors(); 
      if (prevNode != null && neighbors.size() > 1){
        neighbors.remove(prevNode); 
      }
      if (neighbors.size() > 0){
        VulMove = neighbors.get((int)random(neighbors.size()));
        return VulMove;
      }
    }
    return currNode; 
  }

  
  // BREADTH FIRST SEARCHING ALGORITHM 
  ArrayList<Node> selectBestPath(){ //<>//
    
    // reset visited & parent nodes each turn 
    for (Node n : nodes){
        n.TREADED = false; // tracks what nodes have been visited 
        // n.parent = null; // tracks the node it came from 
        n.seq = 0; 
    }
    
    PATH = new chaseFrontier(); 
    PATH.add(currNode); 
    currNode.TREADED = true; 
    currNode.seq = 1; 
    found = false; 
    int max = 0; // track targ seq numb

    while (PATH.size() > 0){
      Node coordinate = PATH.remove(); 
      if (coordinate == target){
        max = coordinate.seq; 
        found = true; 
        break; 
      }
      // For every neighbor the currNode has as a valid option, add it to the frontier 
      ArrayList<Node> neighbors = coordinate.getNeighbors(); 
      //if (coordinate == currNode && prevNode != null){
        //neighbors.remove(prevNode); 
      //}
      for (Node neighbor : neighbors){
        if (!neighbor.TREADED){
          neighbor.TREADED = true; 
          neighbor.seq = coordinate.seq + 1; 
          // System.out.println(neighbor.seq); 
          // neighbor.parent = coordinate; 
          PATH.add(neighbor);
        }
      }
    }
    // grab the best path
    ArrayList<Node> bestPath = new ArrayList<Node> (); 
    if (found){
      Node node = target; 
      int currSeq = max; 
      while (node.seq > 1){
        bestPath.add(0, node); 
        ArrayList<Node> neighbors = node.getNeighbors();
        System.out.println(neighbors); 
        boolean foundPrev = false; 
        // picks the next node in the previous sequence based on sequence number
        for (Node n : neighbors){
          if (n.seq == currSeq - 1){
            System.out.println(node.seq); 
            node = n; 
            currSeq = n.seq; 
            foundPrev = true; 
            break; 
          }
        }
        // node = node.parent; 
        if (!foundPrev) System.out.println("was not able to find a valid path"); 
      }
    }
    // Statement below is just to highlight the path in green 
    for (Node n : bestPath){
      n.pathPart = true; 
    }
    System.out.println(bestPath); 
    return bestPath; 
  }
  
  void update(){
    //This method updates the ghost mode and position
    Node bestNext; 
    if (currNode == nodeGrid[11][10]) {
      // the ghost has returned home
      MODE = CHASE;
      ghostImg = icon;
      speed = 1.5;
    }
    if (MODE == RETURNING) {
       bestNext = pickNextMove( false );
       speed = 5; 
       System.out.print("Return Mode ");
       printNode( target );
       printNode( bestNext );
    }
    else{   
      //the ghost is in Chase mode
      // System.out.println("Ghost is chasing");
      // TUNNEL LOGIC 
      if (currNode.col == 0 && target.col > 15){
          x =  500;
          bestNext = nodeGrid[currNode.row][20];
          //  nextNode = nodeGrid[currNode.row][19];
      }
      else if (currNode.col == 20 && target.col < 5){
          x =  500;
          bestNext = nodeGrid[currNode.row][0];
          //  nextNode = nodeGrid[currNode.row][19];
      }
      else{
        //not in the tunnel
        if( vulnerable ){
          bestNext = pickNextMove( true );
        }
        else
        {
          bestNext = pickNextMove( false ); 
        }

      }
    }
    if (bestNext != null){
      nextNode = bestNext; 
    }
  
    super.inch(); 
  }
  
  void setVulnerable(boolean isVulnerable){
    if (isVulnerable){
      vulnerable = true; 
      ghostImg = blueghost;
      blueTime = millis(); 
      // MODE = BLUE; 
      speed = 1.2; 
    } else {
      MODE = CHASE;
      ghostImg = icon; 
      vulnerable = false; 
      speed = 1.5; 
    }

  }
   
  int getMode(){     
    return MODE;
  }
   
  void setTarget(Node node){
    target = node; 
  }
  

 void timeGhosts(){
    if (vulnerable && millis() - blueTime > 10000){
      setVulnerable(false); 
    }
    // System.out.println(ticks); 
    if (millis() < 10000 && !vulnerable){
      target = nodeGrid[8][10]; 
      MODE = SCATTER;
    }
    else if(MODE != RETURNING){
      MODE = CHASE; 
    } 
  }

   
 void reset(){
    // setTarget(nodeGrid[11][10]); // Ghosts are having a lot of trouble finding their way back to the base... 
    System.out.println("ghost is being reset");
    MODE = RETURNING;
    ghostImg = eyesghost;
    target = nodeGrid[11][10];
    speed = 5; 
    vulnerable = false;
    // setVulnerable(false); 
    //   chase(); 
    if (currNode.row >= 9 && currNode.row <= 11 && currNode.col >= 9 && currNode.col <= 11){
      speed = 1.5;  
    }
    //while not at center be eyes and be in the returning mode --> once out of the returning mode go back to chasse
 }
   
 void display(){
     image(ghostImg, x, y);
     fill(255); 
     text("MODE: " + MODE, x, y); 
 }
   
   /* NOTES: 
   - Should have a target variable so we can store the different targets of each instead of having to reset every time 
   - After blue state is over, ghosts need to target pacman again 
   - Ghosts need to scatter in the beginning and actually leave the box 
   - BFS search would be much better. 
   */
}

  
