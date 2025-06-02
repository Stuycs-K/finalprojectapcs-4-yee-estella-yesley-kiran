int[][] map; 
int SQUARESIZE = 25; 

ArrayList<Node> nodes = new ArrayList<Node>();
Node[][] nodeGrid;

Ghost[] ghosts = new Ghost[3]; // change to 4 later
PImage Blinky, Pinky, Inky; 

//Pacman main; 
Pac Pacman; 
PImage pacman; 

int totalPoints = 0; 
int highScore = totalPoints;
boolean vulnerable = false; 

// setup the map, value of -1 is a wall, value of 1 is a point, value of 0 is an empty space
void setup(){
  size(21*25, 21*25 + 75);
  map = new int[][]{
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
  {-1, -1, -1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1, -1, -1, -1, -1, -1,  1, -1, -1, -1,  1, -1,  1, -1},
  {-1,  1, -1,  1,  1, -1,  1, -1, -1, -1, -1, -1, -1,  1,  1,  1,  1,  1, -1,  1, -1},
  {-1,  1, -1,  1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1, -1, -1,  1, -1,  1, -1},
  {-1,  1, -1, -1,  1,  1, -1,  1, -1, -1, -1, -1, -1,  1, -1, -1, -1,  1,  1,  1, -1},
  {-1,  1, -1,  1, -1,  1,  1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1,  1, -1,  1, -1},
  {-1,  1, -1,  1,  1, -1,  1, -1, -1,  1, -1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1,  1, -1,  1,  1, -1,  0, -1, -1,  0, -1, -1,  0, -1, -1, -1,  1, -1, -1, -1},
  { 1,  1,  1, -1, -1,  1, -1,  0, -1,  0,  0,  0, -1,  0,  1,  1,  1,  1,  1,  1,  1},
  {-1, -1,  1, -1,  1,  1,  1,  0, -1,  0,  0,  0, -1,  0, -1,  1, -1, -1, -1, -1, -1},
  {-1,  1,  1, -1,  1, -1, -1,  0, -1, -1, -1, -1, -1,  0, -1,  1, -1, -1,  1, -1, -1},
  {-1,  1,  1,  1,  1, -1, -1,  0,  0,  0,  0,  0,  0,  0, -1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1,  1,  1,  1,  1, -1, -1,  1, -1, -1,  1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1, -1, -1,  1, -1, -1,  1, -1,  1, -1,  1,  1,  10, -1},
  {-1,  1, -1, -1,  1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1,  1, -1,  1,  1,  1, -1, -1,  1, -1,  1,  1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  1,  1, -1, -1, -1,  1, -1, -1,  1, -1, -1, -1,  1, -1}, 
  {-1,  1, -1,  1, -1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
    };    
    
  genNodes(); 
  connectNodes(); 
  
  pacman = loadImage("PacRight.png");       
  Node start = nodeGrid[13][10]; 
  Pacman = new Pac(start, pacman); 
  Blinky = loadImage("RedGhost.png");
  Pinky = loadImage("PurpleGhost.png"); 
  Inky = loadImage("GreenGhost.png"); 
  ghosts[0] = new Ghost(nodeGrid[11][9], nodeGrid[3][19], Blinky, nodeGrid); 
  ghosts[1] = new Ghost(nodeGrid[11][10], nodeGrid[3][3], Pinky, nodeGrid); 
  ghosts[2] = new Ghost(nodeGrid[11][11], nodeGrid[19][3], Inky, nodeGrid); 
  
  
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
  
  // GHOST MODES  
  
  for (Ghost g : ghosts){
    g.timeGhosts(); 
    g.setVulnerable(vulnerable); 
    if (g.MODE == g.SCATTER){
      if (g.icon == Blinky){
        g.setTarget(nodeGrid[3][19]); 
      }
      if (g.icon == Pinky){
        g.setTarget(nodeGrid[3][3]); 
      }
      if (g.icon == Inky){
        g.setTarget(nodeGrid[19][3]); 
      }
      g.chase(); 
    }
    else if (g.MODE == g.CHASE){
      if (g.icon == Blinky){
        g.setTarget(Pacman.currNode); // MUST CHANGE to account for their different targets leter 
      }
      if (g.icon == Pinky){
        //if (Pacman.icon == Pacman.pacUp){
        //  g.setTarget(nodeGrid[Pacman.row-4][Pacman.col-4]); 
        //}
        g.setTarget(Pacman.currNode); // Set to four tiles ahead
      }
      if (g.icon == Inky){
        g.setTarget(Pacman.currNode); // Change to: the tile 180 degrees from Pacman to Blinky
      }
      g.chase(); 
      // Clyde: Targets Pacman only when he is 8 or more tiles away, otherwise if he's closer he goes into scatter mode
    }
    else if (g.MODE == g.BLUE){
      System.out.println("Transition into vulnerable state"); 
      g.run(); 
    }
    // g.display(); 
  }
  
  Pacman.inch();
  Pacman.display(); 
  
  displayPoints(); 
  totalPoints = Pacman.getScore();
  if (highScore < totalPoints) highScore = totalPoints;
  displayPoints();
  checkContact();
  displayLives();
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
      else {
        fill (255);
        if (map[rows][cols] == 1){
          Node current = nodeGrid[rows][cols];
          if(!current.getEaten())
          circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/4); 
        }
        if (map[rows][cols] == 10){
          Node current = nodeGrid[rows][cols];
          if(!current.getEaten())
          circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/2); 
        }
        
      }
    }
  }
}

void checkContact(){
  for (Ghost g : ghosts){
    if (g.currNode == Pacman.currNode){
      if(g.MODE == g.BLUE){
        g.reset();
        Pacman.addtoScore(100);
      }
      if( reset()) GameOver();
    }
  }
}

void GameOver(){
  fill(0);
  rect(0,0, 21 * SQUARESIZE , 21 * SQUARESIZE);
  fill(255,255,255);
  textSize(25);
  text("GAME OVER", (21 * SQUARESIZE) / 3 , (21 * SQUARESIZE) /2 );
  noLoop();
}

  boolean reset(){
    Pacman.subHealth();
    if(Pacman.getLives() <= 0) return true;
    else {
      Pacman.UP =Pacman.DOWN = Pacman.LEFT = Pacman.RIGHT = false;
      int currtime = second();
      int updatetime = currtime - 1;
      while(second() != currtime + 2){
        if( second() != updatetime ){
          updatetime = second();
          Pacman.icon = Pacman.deathseq.get(updatetime - currtime);
        }
      }
      Pacman.setCurrNode(nodeGrid[13][10], Pacman.pacRight);
      Pacman.nextNode = null;
    }
    return false;
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
