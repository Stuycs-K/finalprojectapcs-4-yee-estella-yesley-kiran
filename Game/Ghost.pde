class Ghost extends character{
  PImage ghostImg; 
  int MODE = 0;
  int SCATTER = 1; // different modes; 
  int CHASE = 2 ;
  int RETURNING = 3;
  
  boolean vulnerable = false;
  int blueTime = 0; 
  PImage blueghost; 
  PImage eyesghost;
  
  Node target;
  Node[][] nodeGrid; 
  int ticks = 0; 
  chaseFrontier chaser = new chaseFrontier(); 
  // pac targetChar; 
  
  Ghost(Node start, Node target, PImage img, Node[][] grid){
     super(start, img);
     ghostImg = icon = img; 
     nodeGrid = grid; 
     this.target = target; 
     MODE = SCATTER;
     
     speed = 1.5; 
     // vulnearbleimg = loadImage("VulnerableGhost.png");
  }
 

  private float distanceToTarget(Node node) {
      float dx = node.row - target.row;
      float dy = node.col - target.col;
      return (float) Math.sqrt(dx * dx + dy * dy);
  }

  Node pickNextMove(boolean escape) {
      //escape = true, means you are running away from your target
      //escape = false means you are running towards your target
      Node bestNext = null;
      float bestDist;
      if (escape) bestDist = Float.MAX_VALUE ;
      else bestDist =Float.MIN_VALUE;
      
      for (Node neighbor : currNode.getNeighbors()) {
          if (neighbor == prevNode) continue;
          
          float dist = distanceToTarget(neighbor);
          if ((escape && dist < bestDist) || (!escape && dist > bestDist)) {
              bestNext = neighbor;
              bestDist = dist;
          }
      }
      return bestNext;
  }

  void update(){
    //This method updates the ghost mode and position
    Node bestNext = null; 
    if (currNode == nodeGrid[11][10]) {
      // the ghost has returned home
      MODE = CHASE;
      ghostImg = icon;
      speed = 1.5;
    }
    if (MODE == RETURNING) {
       bestNext = pickNextMove( false );
       System.out.print("Return Mode ");
       printNode( target );
       printNode( bestNext );
    }
    else{   
      //the ghost is in Chase mode
      // System.out.println("Ghost is chasing");
      //this is the tunnel logic
      if(currNode.col == 0 && target.col > 15){
          x =  500;
          bestNext = nodeGrid[currNode.row][20];
          //  nextNode = nodeGrid[currNode.row][19];
      }
      else if(currNode.col == 20 && target.col < 5){
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
    ticks ++;
  }
  
// BFS Method 
/*  Node makePath(Node prevNode, Node start, Node target){
    if(start == target) return start;
    for(Node n : start.getNeighbors()){
      return chasePath(currNode, n, target);
    }
      return null;
  }
*/

  
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
   
 
  void timeGhosts(){
    if (vulnerable && millis() - blueTime > 10000){
      setVulnerable(false); 
    }
    // System.out.println(ticks); 
    if (ticks < 500 && !vulnerable){
      target = nodeGrid[8][10]; 
      MODE = SCATTER;
    }
    else if(MODE != RETURNING){
      MODE = CHASE; 
    } 
  }
  // void move(int targetx, int targety){
   //}
   
 void reset(){
    //turn to eyes but figure that out later 
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

  
