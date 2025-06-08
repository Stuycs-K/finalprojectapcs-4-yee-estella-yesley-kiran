import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

enum GhostMode {
    SCATTER,
    CHASE,
    RETURNING,
    VULNERABLE
}

class Ghost extends character{
  PImage ghostImg;

  // Define the enum for ghost modes
  GhostMode MODE;
  
  chaseFrontier PATH; 
  boolean found = false; 
  
  //boolean vulnerable = false;
  int blueTime = 0; 
  PImage blueghost; 
  PImage eyesghost;
  
  Node target;
  Node VulMove;
  chaseFrontier chaser = new chaseFrontier(); 

  
  Ghost(Node start, Node target, PImage img){
     super(start, img);
     ghostImg = icon = img; 
     this.target = target; 
     MODE = GhostMode.SCATTER;
     
     speed = 1.5; 
  }
 

  private float distanceToTarget(Node node) {
      float dx = node.row - target.row;
      float dy = node.col - target.col;
      return (float) Math.sqrt(dx * dx + dy * dy);
  }

  
  Node pickNextMove(boolean run){
   // System.out.println("in pickNextMove");
    ArrayList<Node> path = findShortestPath(currNode, target);
    // ArrayList<Node> path = selectBestPath(); 

    if (path != null && path.size() > 0 && !run){
    //  System.out.println( " the nonvuln is running");
 //     System.out.println("Path: " + path); 
      return path.remove(0); 
    }
    // if there is no best path, the ghost should standstill because something is terribly wrong
    else {
    //  System.out.println("b?");
      ArrayList<Node> neighbors = new ArrayList<>(currNode.getNeighbors()); 
      if (prevNode != null && neighbors.size() > 1){
        neighbors.remove(prevNode); 
      }
   //   System.out.println("c?");
      if (neighbors.size() > 0){
        VulMove = neighbors.get((int)random(neighbors.size()));
        return VulMove;
      }
      //System.out.println("d?");
    }
    return currNode;
  }
      
    // BREADTH FIRST SEARCHING ALGORITHM 
    ArrayList<Node> findShortestPath(Node start, Node target) {
        // Reset pathfinding data for all nodes
        for (Node n : nodes) {
            n.parent = null;
            n.TREADED = false;
        }
        
        Queue<Node> frontier = new LinkedList<>();
        
        start.TREADED = true;
        frontier.add(start); //<>//

        Node current = null;
        boolean targetFound = false;

        // BFS main loop
        while (!frontier.isEmpty()) {
            current = frontier.poll();
            if (current == target) {
                targetFound = true;
                break;
            }
            
            // Get the list of neighbors to check how many options we have.
            ArrayList<Node> neighbors = new ArrayList<>(currNode.getNeighbors());
            boolean isDeadEnd = (neighbors.size() == 1);

            for (Node neighbor : current.getNeighbors()) {
                // Do not allow ghosts to reverse direction on the first step of the search
                if (!isDeadEnd && current == start && neighbor == prevNode) {
                    continue;
                }
                if (!neighbor.TREADED) {
                    neighbor.TREADED = true;
                    neighbor.parent = current;
                    frontier.add(neighbor);
                }
            }
        }
        
        // Reconstruct path if the target was found
        if (targetFound) {
            ArrayList<Node> path = new ArrayList<>();
            Node step = target;
            // Backtrack from target to start
            while (step != null && step.parent != start) {
                path.add(0, step); // Add to the beginning of the list
                step = step.parent;
                if (step == null) return null; // Should not happen with correct logic
            }
             if (step != null) {
                path.add(0, step);
            }
            return path;
        }
        
        return null; // No path found
    }

  
  // BREADTH FIRST SEARCHING ALGORITHM 
  ArrayList<Node> selectBestPath(){ 
    
    // reset visited & parent nodes each turn  //<>//
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
      ArrayList<Node> neighbors = new ArrayList<>(currNode.getNeighbors()); 
      //if (coordinate == currNode && prevNode != null){
      //  System.out.println("removing the prevNode"); 
      //  neighbors.remove(prevNode); 
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
        ArrayList<Node> neighbors = new ArrayList<>(currNode.getNeighbors());
        // System.out.println(neighbors); 
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
  
  /*
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
  }
  */
  
    void update() {
      // Go to the next step
      super.inch();
  
      // have arrived at a destination?
      // If we are at a crossroads (or just started), THEN make a decision.
      if (currNode == nextNode || nextNode == null) {
        Node bestNext = null;
        
        // TUNNEL LOGIC --> LOWK Should put this in the selectbestpath method 
            if (currNode.col == 0){
                x =  500;
                prevNode = currNode;
                currNode = nodeGrid[currNode.row][20];
                nextNode = nodeGrid[currNode.row][19];
                return;
            }
            else if (currNode.col == 20 ){
                x =  0;
                prevNode = currNode;
                currNode = nodeGrid[currNode.row][0];
                nextNode = nodeGrid[currNode.row][1];
                return;
            }
  
        if (MODE == GhostMode.RETURNING) {
          target = nodeGrid[11][10];
          bestNext = pickNextMove(false);
          speed = 5;
          ghostImg = eyesghost;
          // Check if we have arrived home AFTER making a move.
          if (currNode == target) {
            MODE = GhostMode.CHASE;
            ghostImg = icon;
            speed = 1.5;
          }
        } else if (MODE == GhostMode.VULNERABLE) {
          ArrayList<Node> neighbors = new ArrayList<>(currNode.getNeighbors());
          if (prevNode != null && neighbors.size() > 1) {
            neighbors.remove(prevNode);
          }
          if (neighbors.size() > 0) {
              bestNext = neighbors.get((int)random(neighbors.size()));
          } else {
              bestNext = currNode; // Stay put if no options
          }
        } else { // This covers CHASE and SCATTER
            bestNext = pickNextMove( false );  //not in tunnel
      }
  
      // Now assign the new destination.
      if (bestNext != null){
         nextNode = bestNext; 
      }
    }
  }
  

  void setVulnerable(boolean isVulnerable){
    System.out.println("in setVulnerable "+isVulnerable );
    if (isVulnerable){
      MODE = GhostMode.VULNERABLE; 
      ghostImg = blueghost;
      blueTime = millis(); 
      speed = 1.2; 
    } else {
      MODE = GhostMode.CHASE;
      ghostImg = icon; 
      speed = 1.5; 
    }

  }
   
  void setTarget(Node node){
    target = node; 
  }
  
  void timeGhosts(){
    if (MODE == GhostMode.VULNERABLE && millis() - blueTime > 8000){
      setVulnerable(false); 
    }
    else if (millis() < restartTime + 10000 && (MODE != GhostMode.VULNERABLE) && (MODE != GhostMode.RETURNING)){
      MODE = GhostMode.SCATTER;
    }
    else if(MODE != GhostMode.RETURNING && MODE != GhostMode.VULNERABLE){
      MODE = GhostMode.CHASE; 
    } 
  }

  public void printStatus() {
      String modeStr = MODE.toString(); 
  
      //String ghostName = "Ghost"; // A default or placeholder name
      String ghostName = this.getClass().getSimpleName();
      if (icon != null && icon.toString().contains("blinky")) { // Example check
          ghostName = "Blinky";
      } else if (icon != null && icon.toString().contains("pinky")) {
          ghostName = "Pinky";
      } else if (icon != null && icon.toString().contains("inky")) {
          ghostName = "Inky";
      } else if (icon != null && icon.toString().contains("clyde")) {
          ghostName = "Clyde";
      }
  
  
      System.out.println(
          "Ghost: " + ghostName +
          " | Mode: " + modeStr +
          " | Position: (" + x + ", " + y + ")" +
          " | Current Node: " + (currNode != null ? currNode.row + "," + currNode.col : "null") +
          " | Next Node: " + (nextNode != null ? nextNode.row + "," + nextNode.col : "null") +
          " | Target: " + (target != null ? target.row + "," + target.col : "null") +
          " | Speed: " + speed +
          (MODE == GhostMode.VULNERABLE ? " | Vulnerable Time Left: " + Math.max(0, 8000 - (millis() - blueTime)) / 1000.0 + "s" : "")
      );
  }

 
 void reset(){
    System.out.println("ghost is being reset");
    MODE = GhostMode.RETURNING; //<>//
    ghostImg = eyesghost;
    target = nodeGrid[11][10]; //home base //<>//
    speed = 3; 
    System.out.println("ghost is being reset");
    if (currNode.row >= 9 && currNode.row <= 11 && currNode.col >= 9 && currNode.col <= 11){
      speed = 1.5;  
    }
    //while not at center be eyes and be in the returning mode --> once out of the returning mode go back to chasse
 }
   
 void display(){
     image(ghostImg, x, y);
     //fill(255); 
     //text("MODE: " + MODE, x, y); 
     //text("target:" + target, x , y +15);
 }
   
   /* NOTES: 
   - Should have a target variable so we can store the different targets of each instead of having to reset every time 
   - After blue state is over, ghosts need to target pacman again 
   - Ghosts need to scatter in the beginning and actually leave the box 
   - BFS search would be much better. 
   */
}

  
