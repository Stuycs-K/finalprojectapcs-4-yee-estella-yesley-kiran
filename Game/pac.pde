class Pac extends character{
  boolean UP =false;
  boolean DOWN = false;
  boolean RIGHT = false;
  boolean LEFT = false; 
  int score = 0;
  int lives = 3;
 
  PImage pacUp, pacDown, pacRight, pacLeft; 
  ArrayList<PImage> deathseq= new ArrayList<PImage>();
  
  Pac(Node startNode, PImage img){
    super(startNode, img);
     pacRight = loadImage("PacRight.png");       
     pacLeft = loadImage("PacLeft.png");      
     pacUp = loadImage("PacUp.png");   
     pacDown = loadImage("PacDown.png");
     
      PImage death1 = loadImage("death1.png");
      PImage death2 = loadImage("death2.png");
      PImage death3 = loadImage("death3.png");
     
      deathseq.add(death1);
      deathseq.add(death2);
      deathseq.add(death3);
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
      score+=currNode.value;
      x =  500;
      currNode = nodeGrid[currNode.row][20];
      nextNode = nodeGrid[currNode.row][19];
      currNode.beEaten();
      score+=currNode.value;
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
    if(currNode != null && !currNode.getEaten() && currNode.getValue() > 0){
      if(currNode.getValue() == 10){
         for (Ghost g : ghosts){
           g.setVulnerable(true);
           System.out.println("Vulnerable state activated"); 
         }
      //  for(Ghost g: ghosts) 
      //    g.setVulnerable(true); 
      //    System.out.println("Transition into Blue State"); 
      //    System.out.println(g.getMode()); 
      }
      currNode.beEaten();
      score+=currNode.value;
    }
  }
  }
  
  void move(String dir){
    //int[] next = new int[2]; 
    //int[][] directions = {
    //  {-1, 0}, {1, 0}, {0, -1}, {0, 1} // UP, DOWN, LEFT, RIGHT 
    //}; 
    // for (Node n : currNode.getNeighbors()){
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
    // }
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
  
  public void addtoScore(int val){
    score += val;
  }
  
  //boolean reset(){
  //  subHealth();
  //  if(getLives() < 0) return true;
  //  else {
  //    UP =DOWN = LEFT = RIGHT = false;
  //    int currtime = second();
  //    int updatetime = currtime - 1;
  //    while(second() != currtime + 2){
  //      if( second() != updatetime ){
  //        updatetime = second();
  //        icon = deathseq.get(updatetime - currtime);
  //      }
  //    }
  //    this.setCurrNode(nodeGrid[13][10], pacRight);
  //    nextNode = null;
  //  }
  //  return false;
  //}
}
