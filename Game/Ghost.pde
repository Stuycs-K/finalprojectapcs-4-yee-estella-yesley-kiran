class Ghost extends character{
  PImage ghostImg; 
  int SCATTER = 0; // different modes; 
  int CHASE = 1; 
  int BLUE = 2; 
  boolean vulnerable = false;
  Node prevNode; 
  Node target;
  int targetRow, targetCol; 
  Node[][] nodeGrid; 
  int ticks = 0; 
  chaseFrontier front; 
  
  Ghost(Node start, Node target, PImage img, Node[][] grid){
     super(start, img);
     ghostImg = img; 
     nodeGrid = grid; 
     prevNode = null; 
     this.target = target; 
     targetRow = target.row; 
     targetCol = target.col; 
  }
  
  void setTarget(Node targNode){
    target = targNode; 
    targetRow = target.row; 
    targetCol = target.col; 
    
  }
  
  void chase(){
    super.inch(); 
    ticks ++; 
    if (target != null){
      ArrayList<Node> path = chasePath(prevNode, currNode, target); 
      nextNode = path.get(1); 
    }
  }
  
  ArrayList<Node> chasePath(Node prevNode, Node start, Node target){
    ArrayList<Node> path = new ArrayList<Node>(); 
    ArrayList<Node> neighbors = currNode.getNeighbors();
    
    int rows = nodeGrid.length; 
    int cols = nodeGrid[0].length; 
    chaseFrontier chaser = new chaseFrontier(); 
    chaser.add(start); 
    
    while (chaser.size() > 0){
      int[] current = chaser.remove(); 
      int row = current[0]; 
      int col = current[1]; 
      Node currentNode = nodeGrid[row][col]; 
       
      for (Node n : neighbors){
        chasePath(currNode, n, target); 
      }
    
    }
    // implement that the ghost is not allowed to turn 180 degrees; it cannot go back the direction it was moving in
   
    return path; 
  }
  
  void setVulnerable(){
     // change character image to blue weird ghost 
     // change contact thing --> so that they can be eaten    
  }
   
  boolean getVulnerable(){     
    return vulnerable;
  }
   
  // void move(int targetx, int targety){
   //}
}
