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
  chaseFrontier chaser = new chaseFrontier(); 
  
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
      chaser.add(currNode); 
      ArrayList<Node> path = chasePath(prevNode, currNode, target); 
      nextNode = path.get(1); 
    }
  }
  
  ArrayList<Node> chasePath(Node prevNode, Node start, Node target){
    ArrayList<Node> path = new ArrayList<Node>(); 
    ArrayList<Node> neighbors = currNode.getNeighbors();
    
    ArrayList<Node> p1 = new ArrayList<Node>(); 
    ArrayList<Node> p2 = new ArrayList<Node>(); 
    ArrayList<Node> p3 = new ArrayList<Node>(); 
    
    // implement that the ghost is not allowed to turn 180 degrees; it cannot go back the direction it was moving in

    int rows = nodeGrid.length; 
    int cols = nodeGrid[0].length; 
   
    for (int i = 1; i <=3; i ++){
      Node n = neighbors.get(i); 
      chaser.add(n); 
    }
    System.out.println(chaser); 
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
