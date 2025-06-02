class Ghost extends character{
  PImage ghostImg; 
  int MODE = 0; 
  int SCATTER = 0; // different modes; 
  int CHASE = 1; 
  int BLUE = 2; 
  boolean vulnerable = false;
  
  Node target;
  int targetRow, targetCol; 
  Node[][] nodeGrid; 
  int ticks = 0; 
  chaseFrontier chaser = new chaseFrontier(); 
//  pac targetChar; 
  
  Ghost(Node start, Node target, PImage img, Node[][] grid){
     super(start, img);
     ghostImg = img; 
     nodeGrid = grid; 
     this.target = target; 
     targetRow = target.row; 
     targetCol = target.col; 
     
     speed = 1.5; 
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
        System.out.println("180 turn: " + prevNode); 
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
  
  void setVulnerable(){
     // change character image to blue weird ghost 
     // change contact thing --> so that they can be eaten    
  }
   
  boolean getVulnerable(){     
    return vulnerable;
  }
   
 
  void timeGhosts(){
    if (ticks > 10){
      MODE = CHASE; 
    }
  }
  // void move(int targetx, int targety){
   //}
}
