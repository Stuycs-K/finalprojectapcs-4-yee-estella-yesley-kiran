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
    ArrayList<Node> path = findShortestPath(currNode, target);

    if (path != null && path.size() > 0 && !run){
      return path.remove(0); 
    }
    // if there is no best path, the ghost should standstill because something is terribly wrong
    else {
      ArrayList<Node> neighbors = new ArrayList<>(currNode.getNeighbors()); 
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
    ArrayList<Node> findShortestPath(Node start, Node target) {
        // Reset pathfinding data for all nodes
        for (Node n : nodes) {
            n.parent = null;
            n.TREADED = false;
        }
        
        Queue<Node> frontier = new LinkedList<>();
        
        start.TREADED = true;
        frontier.add(start);

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
  
    void update() {
      // Go to the next step
      super.inch();
  
      // have arrived at a destination?
      // If we are at a crossroads (or just started), THEN make a decision.
      if (currNode == nextNode || nextNode == null) {
        Node bestNext = null;
        
        // TUNNEL LOGIC 
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
    MODE = GhostMode.RETURNING; 
    ghostImg = eyesghost;
    target = nodeGrid[11][10]; 
    speed = 3; 
    if (currNode.row >= 9 && currNode.row <= 11 && currNode.col >= 9 && currNode.col <= 11){
      speed = 1.5;  
    }
 }
   
 void display(){
     image(ghostImg, x, y);

 }
   
}

  
