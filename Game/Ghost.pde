class Ghost extends character{
  PImage ghostImg; 
  int MODE = 0; 
  int SCATTER = 0; // different modes; 
  int CHASE = 1; 
  int BLUE = 2; 
  
  boolean vulnerable = false;
  int blueTime = 0; 
  PImage blueghost; 
  
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
    // System.out.println("Ghost is chasing");
    Node bestNext = null; 
    float minDist = Float.MAX_VALUE; 
    float maxDist = Float.MIN_VALUE; 
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
    // bestNext = makePath(prevNode, currNode, target);
    if (bestNext != null){
      nextNode = bestNext; 
    }
    
    super.inch(); 
    ticks ++;
    
    //if (target != null){
      //chaser.add(currNode); 
      //ArrayList<Node> path = chasePath(prevNode, currNode, target); 
      //nextNode = path.get(1); 
    // }
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
      System.out.println("ghostImage changed"); 
      blueTime = millis(); 
      MODE = BLUE; 
    } else {
      MODE = CHASE;
      ghostImg = icon; 
      vulnerable = false; 
    }
    
     // change character image to blue weird ghost 
     // change contact thing --> so that they can be eaten    
  }
   
  int getMode(){     
    return MODE;
  }
   
 
  void timeGhosts(){
    if (vulnerable && millis() - blueTime > 5000){
      setVulnerable(false); 
    }
    // System.out.println(ticks); 
    if (ticks < 500 && MODE != BLUE){
      setTarget(nodeGrid[8][10]); 
      MODE = SCATTER;
    }
    else {
      MODE = CHASE; 
    } 
  }
  // void move(int targetx, int targety){
   //}
   
   void reset(){
      //turn to eyes but figure that out later 
      this.setTarget(nodeGrid[11][10]);
      //while not at center be eyes and be in the returning mode --> once out of the returning mode go back to chasse
   }
   
   void display(){
     image(ghostImg, x, y); 
   }
}

  
