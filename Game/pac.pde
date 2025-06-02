class pac extends character{
  boolean UP =false;
  boolean DOWN = false;
  boolean RIGHT = false;
  boolean LEFT = false; 
  int score = 0;
  int lives = 3;
 
  PImage pacUp, pacDown, pacRight, pacLeft; 
  
  pac(Node startNode, PImage img){
    super(startNode, img);
     pacRight = loadImage("PacRight.png");       
     pacLeft = loadImage("PacLeft.png");      
     pacUp = loadImage("PacUp.png");   
     pacDown = loadImage("PacDown.png");
  }
  
  void inch(){
    super.inch(); 
    // only change directions once pacman gets to the center of a node 
    if (abs ( x - currNode.x) < 0.1 && abs(y - currNode.y) < 0.1){
      update(); 
    }
  }
  
  void update(){
    if(currNode.col -1 < 0 && LEFT){
      currNode.beEaten();
      score++;
      x =  500;
      currNode = nodeGrid[currNode.row][20];
      nextNode = nodeGrid[currNode.row][19];
      currNode.beEaten();
      score++;
    }
    else if(currNode.col +1 > 20 && RIGHT){
      currNode.beEaten();
      score++;
      x = 0;
      currNode = nodeGrid[currNode.row][0];
      nextNode = nodeGrid[currNode.row][1];
      currNode.beEaten();
      score++;
    }
    else{
    if (UP){
      move(-1, 0); 
      icon = pacUp; 
    }
    else if (DOWN){
      move(1, 0);
      icon = pacDown; 
    }
    else if (LEFT){
      move(0, -1); 
      icon = pacLeft; 
    }
    else if (RIGHT){
      move(0, 1); 
      icon = pacRight; 
    }
    if(currNode != null && !currNode.getEaten() && currNode.getValue() == 1){
      currNode.beEaten();
      score++;
    }
  }
  }
  
  void move(String dir){
    //int[] next = new int[2]; 
    //int[][] directions = {
    //  {-1, 0}, {1, 0}, {0, -1}, {0, 1} // UP, DOWN, LEFT, RIGHT 
    //}; 
    for (Node n : currNode.getNeighbors()){
      if (dir.equals("up") && (nextNode == null || checkNeighbor(-1, 0)) ){
        UP = true; 
        DOWN = RIGHT = LEFT = false; 
      }
      else if (dir.equals("down") && (nextNode == null || checkNeighbor(1, 0)) ){
        DOWN = true; 
        UP = RIGHT = LEFT = false; 
      }
      else if (dir.equals("left") && (nextNode == null ||checkNeighbor(0, -1))){
        LEFT = true;
        UP = RIGHT = DOWN = false;  
      }
      else if (dir.equals("right") && (nextNode == null ||checkNeighbor(0, 1))){
        RIGHT = true; 
        UP = DOWN = LEFT = false;
      }
    }
  }
  
  boolean checkNeighbor( int dr ,int dc){
    /*
    for (Node neighbor : currNode.neighbors){ 
     if (neighbor.row == currNode.row + dr && neighbor.col == currNode.col + dc)return true; 
     System.out.println( neighbor.row + ", " + (currNode.row + dr) + ", " + neighbor.col + ", " + (currNode.col + dc));
    }
    */
    for (Node neighbor : nextNode.neighbors){ 
     if (neighbor.row == nextNode.row + dr && neighbor.col == nextNode.col + dc){
       return true; 
     }
     // System.out.println( neighbor.row + ", " + (nextNode.row + dr) + ", " + neighbor.col + ", " + (nextNode.col + dc));
    }
    return false;
  }
  
  void subHealth(){
    lives--;
  }
  
  int getLives(){
    return lives;
  }
  
  public int getScore(){
    return score; 
  }
}
