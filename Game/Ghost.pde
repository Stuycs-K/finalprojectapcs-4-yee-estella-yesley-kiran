class Ghost extends character{
  // PImage ghostImg; 
  int MODE = 0; 
  int SCATTER = 0; // different modes; 
  int CHASE = 1; 
  int BLUE = 2; 
  // boolean vulnerable = false;
  // PImage vulnearbleimg;
  PImage icon;
  
  Node target;
  int targetRow, targetCol; 
  Node[][] nodeGrid; 
  int ticks = 0; 
  chaseFrontier chaser = new chaseFrontier(); 
  // pac targetChar; 
  
  Ghost(Node start, Node target, PImage img, Node[][] grid){
     super(start, img);
     icon = img; 
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
    // sqrt(map.length * map.length + map[0].length * map[0].length); 
    ArrayList<Node> neighbors = currNode.getNeighbors(); 
    for (Node neighbor : neighbors){
      // System.out.println(neighbor); 
      // System.out.println(prevNode);
      if (neighbor != prevNode){
        // System.out.println("180 turn: " + prevNode); 
        float dist = sqrt((neighbor.row-target.row)*(neighbor.row-target.row) + (neighbor.col-target.col)*(neighbor.col-target.col));
        if (dist < minDist){
          bestNext = neighbor; 
          // System.out.println(bestNext); 
          minDist = dist; 
        }
      }
    }
    //System.out.println(minDist);
    // bestNext = makePath(prevNode, currNode, target);
    if (bestNext != null){
      // System.out.println(bestNext); 
      nextNode = bestNext; 
    }
    
    super.inch(); 
    display(); 
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

  void run(){
    
  }
  
  void setVulnerable(boolean bool){
    if (bool){
      MODE = BLUE; 
      icon = loadImage("VulnerableGhost.png");
    } else {
      MODE = CHASE;
    }
    
    //ghostImg = vulnearbleimg;
    //vulnerable = true;
    //}
    //else{
    //  ghostImg = icon;
    //  vulnerable = false;
    //}
     // change character image to blue weird ghost 
     // change contact thing --> so that they can be eaten    
  }
   
  int getMode(){     
    return MODE;
  }
   
 
  void timeGhosts(){
    // System.out.println(ticks); 
    if (ticks < 500){
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
      
   }
}

  
