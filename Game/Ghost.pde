class Ghost extends character{
  PImage ghostImg; 
  int MODE = 0; 
  int SCATTER = 0; // different modes; 
  int CHASE = 1; 
  int RETURNING = 3;
  // int BLUE = 2; 
  
  boolean vulnerable = false;
  int blueTime = 0; 
  PImage blueghost; 
  PImage eyesghost;
  
  Node target;
  int targetRow, targetCol; 
  Node[][] nodeGrid; 
  int ticks = 0; 
  chaseFrontier chaser = new chaseFrontier(); 
  // pac targetChar; 
  
  Ghost(Node start, Node target, PImage img, Node[][] grid){
     super(start, img);
     ghostImg = icon = img; 
     nodeGrid = grid; 
     this.target = target; 
     targetRow = target.row; 
     targetCol = target.col; 
     MODE = SCATTER;
     
     speed = 1.5; 
     // vulnearbleimg = loadImage("VulnerableGhost.png");
  }
 
  void setTarget(Node targNode){
    target = targNode; 
    targetRow = target.row; 
    targetCol = target.col; 
  }
  
  //void setTarget(int targetR, int targetC){ 
  //  targetRow = targetR; 
  //  targetCol = targetC; 
  //  target = nodeGrid[targetRow][targetCol]; 
  //}

  void chase(){
    Node bestNext = null; 
    if (MODE == RETURNING) {
     ghostImg = eyesghost;
    setTarget(nodeGrid[11][10]);
    float minDist = Float.MAX_VALUE;

    for (Node neighbor : currNode.getNeighbors()) {
      if (neighbor != prevNode) {
        float dist =  sqrt((neighbor.row-target.row)*(neighbor.row-target.row) + (neighbor.col-target.col)*(neighbor.col-target.col));
        if (dist < minDist) {
          minDist = dist;
          bestNext = neighbor;
        }
      }
    }
    if (currNode == nodeGrid[11][10]) {
      MODE = CHASE;
      ghostImg = icon;
      speed = 1.5;
    }
    System.out.println( "is this running");
  }
  else{   
    // System.out.println("Ghost is chasing");
    float minDist = Float.MAX_VALUE; 
    float maxDist = Float.MIN_VALUE; 
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
    ArrayList<Node> neighbors = currNode.getNeighbors(); 
    for (Node neighbor : neighbors){
      if (neighbor != prevNode){
        float dist = sqrt((neighbor.row-target.row)*(neighbor.row-target.row) + (neighbor.col-target.col)*(neighbor.col-target.col));
        if (vulnerable){
          if (dist > maxDist){
            bestNext = neighbor; 
            maxDist = dist; 
          }
        }
        else{
          if (dist < minDist){
            bestNext = neighbor; 
            minDist = dist; 
          }
        }
      }
    }
    }
    // bestNext = makePath(prevNode, currNode, target);
    if (bestNext != null){
      nextNode = bestNext; 
    }
    
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
      setTarget(nodeGrid[8][10]); 
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

  
