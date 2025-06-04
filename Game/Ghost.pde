class Ghost extends character{
  PImage ghostImg; 
  int MODE = 0;
  int SCATTER = 1; // spreads out to the corners 
  int CHASE = 2 ; // chase Pacman
  int RETURNING = 3; // return to base after being eaten
  
  chaseFrontier PATH; 
  
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

  Node pickNextMove(boolean run) {
      //run = true, means you are running away from your target
      //run = false means you are running towards your target
      Node bestNext = null;
      float bestDist;
      if (run) bestDist = Float.MAX_VALUE ;
      else bestDist =Float.MIN_VALUE;
      
      for (Node neighbor : currNode.getNeighbors()) {
          if (neighbor == prevNode) continue;
          
          float dist = distanceToTarget(neighbor);
          if ((run && dist < bestDist) || (!run && dist > bestDist)) {
              bestNext = neighbor;
              bestDist = dist;
          }
      }
      return bestNext;
  }
  
  // BREADTH FIRST SEARCHING ALGORITHM 
  ArrayList<Node> move(){
    ArrayList<Node> bestPath = new ArrayList<Node> (); 
    if (PATH.size()==0){
      // should return the path that reaches the target first
      return bestPath;   
    }
    int[][] dir = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}}; 
    int[] coordinate = FLARES.remove(); 
    int y = coordinate[0]; int x = coordinate[1]; 
    map[y][x] = ASH; 
    for (int k = 0; k < 4; k ++){
        int newY = y + dir[k][0]; 
        int newX = x + dir[k][1]; 
        if (newY < map.length && newY >= 0 && newX >= 0 && newX < map[newY].length && map[newY][newX] == TREE){
          map[newY][newX] = FIRE; 
          FLARES.add(new int[]{newY, newX});
          ticks ++;
        }
        else if (newY < map.length && newY >= 0 && newX >= 0 && newX < map[newY].length && map[newY][newX] == 'E'){
          burnt = true; 
        }
      }  
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
       speed = 5; 
       System.out.print("Return Mode ");
       printNode( target );
       printNode( bestNext );
    }
    else{   
      //the ghost is in Chase mode
      // System.out.println("Ghost is chasing");
      // TUNNEL LOGIC 
      if (currNode.col == 0 && target.col > 15){
          x =  500;
          bestNext = nodeGrid[currNode.row][20];
          //  nextNode = nodeGrid[currNode.row][19];
      }
      else if (currNode.col == 20 && target.col < 5){
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

  
