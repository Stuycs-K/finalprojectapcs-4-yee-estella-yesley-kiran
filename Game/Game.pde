int[][] map; 
int SQUARESIZE = 25; 

ArrayList<Node> nodes = new ArrayList<Node>();
Node[][] nodeGrid;

ArrayList<Ghost> ghosts = new ArrayList<Ghost>(); // change to 4 later
PImage redG, purpG, greenG, Blue,Eyes; 
Blinky blinky; 
Pinky pinky; 
Inky inky; 

//Pacman main; 
Pac Pacman; 
PImage pacman; 

int totalPoints = 0; 
int highScore = totalPoints;
// boolean vulnerable = false; 

boolean fresh = false;
int freshtime =0;
// setup the map, value of -1 is a wall, value of 1 is a point, value of 0 is an empty space
void setup(){
  size(21*25, 21*25 + 75);
  map = new int[][]{
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
  {-1, -1, -1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1, -1, -1, -1, -1, -1,  1, -1, -1, -1,  1, -1,  1, -1},
  {-1,  1, -1,  1,  1, -1,  1, -1, -1, -1, -1, -1, -1,  1,  10,  1,  1,  1, -1,  1, -1},
  {-1,  1, -1,  1, -1,  10,  1,  1,  1,  1,  1,  1,  1,  1, -1, -1, -1,  1, -1,  1, -1},
  {-1,  1, -1, -1,  1,  1, -1,  1, -1, -1, -1, -1, -1,  1, -1, -1, -1,  1,  1,  1, -1},
  {-1,  1, -1,  1, -1,  1,  1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1,  1, -1,  1, -1},
  {-1,  1, -1,  1,  1, -1,  1, -1, -1,  1, -1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1,  1, -1,  1,  1, -1,  0, -1, -1,  0, -1, -1,  0, -1, -1, -1,  1, -1, -1, -1},
  { 1,  1,  1, -1, -1,  1, -1,  0, -1,  0,  0,  0, -1,  0,  1,  1,  1,  1,  1,  1,  1},
  {-1, -1,  1, -1,  1,  1,  1,  0, -1,  0,  0,  0, -1,  0, -1,  1, -1, -1, -1, -1, -1},
  {-1,  1,  1, -1,  1, -1, -1,  0, -1, -1, -1, -1, -1,  0, -1,  1, -1, -1,  1, -1, -1},
  {-1,  1,  1,  1,  1, -1, -1,  0,  0,  0,  0,  0,  0,  0, -1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1,  10,  1,  1,  1, -1, -1,  1, -1, -1,  1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1, -1, -1,  1, -1, -1,  1, -1,  1, -1,  1,  1,  10, -1},
  {-1,  1, -1, -1,  1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1,  1, -1,  1,  1,  1, -1, -1,  1, -1,  1,  1,  1, -1},
  {-1,  1, -1, -1,  1,  1,  1,  1,  1, -1, -1, -1,  1, -1, -1,  1, -1, -1, -1,  1, -1}, 
  {-1,  1,  1,  1,  1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
    };    
    
  genNodes(); 
  connectNodes(); 
  
  pacman = loadImage("PacRight.png");       
  Node start = nodeGrid[13][10]; 
  Pacman = new Pac(start, pacman); 
  redG = loadImage("RedGhost.png");
  purpG = loadImage("PurpleGhost.png"); 
  greenG = loadImage("GreenGhost.png"); 
  Blue = loadImage("VulnerableGhost.png");
  Eyes = loadImage("DeadGhostEyes.png");
  
  
  
  blinky = new Blinky(nodeGrid[11][9], nodeGrid[3][19], redG); 
  pinky = new Pinky(nodeGrid[11][10], nodeGrid[3][3], purpG); 
  inky = new Inky(nodeGrid[11][11], nodeGrid[19][3], greenG); 
  ghosts.add(blinky); 
  ghosts.add(pinky); 
  ghosts.add(inky); 
  for (Ghost g : ghosts){
    g.blueghost = Blue; 
    g.eyesghost = Eyes;
  }
  
}  

//creating nodes and stuff:
boolean isWalkable(int r, int c){
  return r >= 0 && r <map.length && c < map[0].length && c >= 0 && map[r][c] >= 0;
}

void genNodes(){
  nodeGrid = new Node[map.length][map[0].length];
  for( int r = 0; r < map.length; r++){
    for(int c = 0; c < map[0].length; c++){
      if(map[r][c] >= 0){
        Node n = new Node(r, c, map[r][c]);
        nodes.add(n);
        nodeGrid[r][c] = n;
      }
    }
  }
}

public void connectNodes(){
  for(Node n: nodes){
    int col = n.col; 
    int row = n.row; 
    int[][] dir = { {0, 1} , {0, -1} , {1,0} , {-1, 0}};
    //up 
    for( int i = 0 ; i < dir.length; i++){
      int newr = row + dir[i][0]; 
      int newc = col + dir[i][1]; 
      if(isWalkable(newr, newc)){
        n.addNeighbor(nodeGrid[newr][newc]);
      }
    }  
    if (row == 10 && col == 0){
      n.addNeighbor(nodeGrid[row][map.length-1]); 
    }
    if (row == 10 && col == map.length-1){
      n.addNeighbor(nodeGrid[row][0]); 
    }
  }
}

// POINT SYSTEM 
public void calcPoints(){
  
}

public void displayPoints(){
  fill(255,255,255);
  textSize(25);
  text("High Score: " + highScore, (21 * 25) /3 , (21 * 25) + 30);
  text( "Current Score: " + totalPoints , (21 * 25) /3 , (21 * 25) +55);

}

public void displayLives(){
    fill(255,255,255);
    textSize(25);
    text("Lives : " + Pacman.getLives(),0, (21 * 25) + 30 );

}

public void draw(){
  background(0); 
  drawSquares(map);
  //for(Node n: nodes){
  //  n.displayNodes();
  //  n.displayEdges();
  //}
  
  Pacman.inch();
  Pacman.display();
  // GHOST MODES  
  
  // To visualize the paths: 
  
  for (Node n : nodes){
    n.pathPart = false; 
  }
  // System.out.println("before ghosts" + millis());
  for (Ghost g : ghosts){
    g.printStatus();
    g.timeGhosts(); 
    if (g.MODE == GhostMode.SCATTER){
      System.out.println("scatter");
      if (g == blinky){
        g.target = nodeGrid[3][19]; 
      }
      if (g == pinky){
        g.target = nodeGrid[2][1]; 
      }
      if (g == inky){
        g.target = nodeGrid[18][1]; 
      }
    }
    else if (g.MODE == GhostMode.CHASE){
            g.setTarget(Pacman.currNode); 
    }
    else if (g.MODE == GhostMode.RETURNING){
            System.out.println("returning");
      g.target = nodeGrid[11][10]; 
      g.speed = 5; 
      g.ghostImg = Eyes; 
      if (g.currNode == nodeGrid[11][10]) {
         // the ghost has returned home
        g.MODE = GhostMode.CHASE;
        g.ghostImg = g.icon;
        g.speed = 1.5;
        
      }
      System.out.println("end of returning");

    }
    /*
    else if (g.MODE == g.VULNERABLE){
      
      ArrayList<Node> neighbors = g.currNode.getNeighbors();
      neighbors.remove(g.prevNode); 
      if (neighbors.size() == 0 && g.prevNode != null){
        g.target = g.prevNode; 
      }else {
        
      int temp = (int)random(neighbors.size()); 
      g.target = neighbors.get(temp); 
      
      }
      System.out.println("BLUE MODE: " + g.target); 
     }
    */
    g.update(); 
    g.display();
  }
  
  checkContact();
  timers();
  System.out.println("timers" + millis());
  displayPoints(); 
  totalPoints = Pacman.getScore();
  if (highScore < totalPoints) highScore = totalPoints;
  displayPoints();
  displayLives();
  System.out.println(millis());
}

/* Draw the walls, points, etc 
For later: 
 - add in different pixels for each fruit/point 
 - make this actually look good 
*/ 
void drawSquares(int[][] map){
  for (int rows = 0; rows < map.length; rows ++){
    for (int cols = 0; cols < map[0].length; cols ++){
      if(map[rows][cols] < 0){
        fill (0, 0, 255); 
        rect(cols * SQUARESIZE, rows * SQUARESIZE, SQUARESIZE, SQUARESIZE); 
      }
      // checks the pathfinding mechanism of ghost
      //if (nodeGrid[rows][cols] != null && nodeGrid[rows][cols].pathPart == true){
      //  fill(0, 255, 0); 
      //  rect(cols * SQUARESIZE, rows * SQUARESIZE, SQUARESIZE, SQUARESIZE); 
      //}
      else {
        fill (255);
        if (map[rows][cols] == 1){
          Node current = nodeGrid[rows][cols];
          if(!current.eaten)
          circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/4); 
        }
        if (map[rows][cols] == 10){
          Node current = nodeGrid[rows][cols];
          if(!current.eaten)
          circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/2); 
        }
        
      }
    }
  }
}

void checkContact(){ 
  for (Ghost g : ghosts){
    if (g.currNode == Pacman.currNode){ 
       if(g.MODE == GhostMode.VULNERABLE ){
          g.reset(); // Right now Pacman is dying even when ghosts are in blue mode
          Pacman.addtoScore(100);
          fresh =true; //add a timer to this but for now its just so incredibly unlikely a ghost kills u near to when u kill a ghost 
          freshtime =  millis();
      }
      else if(!(g.MODE == GhostMode.RETURNING) && !fresh && Pacman.reset()) 
        GameOver(); //<>//
    }
  }
}

void timers(){
  if (millis() - freshtime > 5000) fresh= false;
}

void GameOver(){
  fill(0);
  rect(0,0, 21 * SQUARESIZE , 21 * SQUARESIZE);
  fill(255,255,255);
  textSize(25);
  text("GAME OVER", (21 * SQUARESIZE) / 3 , (21 * SQUARESIZE) /2 );
  noLoop();
}

public void keyPressed(){
  if (key == CODED){
    if (keyCode == UP) {
      Pacman.move("up");
    } else if (keyCode == DOWN) {
      Pacman.move("down");
    } else if (keyCode == RIGHT) {
      Pacman.move("right");
    } else if (keyCode == LEFT){
      Pacman.move("left"); 
    }
  }
}
