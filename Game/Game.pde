int[][] map; 
int SQUARESIZE = 25; 

ArrayList<Node> nodes = new ArrayList<Node>();
Node[][] nodeGrid;

Ghost[] ghosts = new Ghost[3]; // change to 4 later
PImage Blinky, Pinky, Inky, Blue,Eyes; 

//Pacman main; 
Pac Pacman; 
PImage pacman; 

int totalPoints = 0; 
int highScore = totalPoints;
// boolean vulnerable = false; 

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
  Blue = loadImage("VulnerableGhost.png");
  Eyes = loadImage("DeadGhostEyes.png");
  ghosts[0] = new Ghost(nodeGrid[11][9], nodeGrid[3][19], Blinky, nodeGrid); 
  ghosts[1] = new Ghost(nodeGrid[11][10], nodeGrid[3][3], Pinky, nodeGrid); 
  ghosts[2] = new Ghost(nodeGrid[11][11], nodeGrid[19][3], Inky, nodeGrid); 
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
  for (Ghost g : ghosts){
    g.timeGhosts(); 
    if (g.MODE == g.SCATTER){
      if (g.ghostImg == Blinky){
        g.target = nodeGrid[3][19]; 
      }
      if (g.ghostImg == Pinky){
        g.target = nodeGrid[3][3]; 
      }
      if (g.ghostImg == Inky){
        g.target = nodeGrid[19][3]; 
      }
    }
    else if (!(g.vulnerable) && g.MODE == g.CHASE){
      if (g.ghostImg == Blinky){
        g.target = Pacman.currNode; // MUST CHANGE to account for their different targets leter 
      }
      if (g.ghostImg == Pinky){ // targets the node four tiles ahead of Pacman 
        int targetRow = Pacman.currNode.row; 
        int targetCol = Pacman.currNode.col; 
        if (Pacman.icon == Pacman.pacUp){ // When Pacman faces up, ghost target four up and four to the left
          targetRow = Pacman.currNode.row - 4; 
          targetCol = Pacman.currNode.row - 4; 
        }
        else if (Pacman.icon == Pacman.pacLeft){
          targetCol = Pacman.currNode.col - 4; 
          targetRow = Pacman.currNode.row; 
        }
        else if (Pacman.icon == Pacman.pacRight){
          targetCol = Pacman.currNode.col + 4; 
          targetRow = Pacman.currNode.row; 
        }
        else if (Pacman.icon == Pacman.pacDown){
          targetCol = Pacman.currNode.col; 
          targetRow = Pacman.currNode.row + 4; 
        }
        if (targetRow >= 0 && targetCol >= 0)
          g.target = nodeGrid[targetRow][targetCol];
        else {
          g.target = nodeGrid[Pacman.currNode.row][Pacman.currNode.col]; 
        }
      }
      if (g.ghostImg == Inky){
        g.target = Pacman.currNode; // Change to: the tile 180 degrees from Pacman to Blinky
      }
      // Clyde: Targets Pacman only when he is 8 or more tiles away, otherwise if he's closer he goes into scatter mode
    }
    else if (g.vulnerable && g.MODE == g.CHASE){
     // System.out.println("Transition into vulnerable state"); 
      // g.setVulnerable(true); 
      g.target = Pacman.currNode; // makes it run away from pacman 
    }
    else if(g.MODE == g.RETURNING){
      //System.out.println( "this 1 is running");
      g.target = nodeGrid[11][10];
      if(g.currNode ==nodeGrid[9][10]){
        g.MODE =g.CHASE;
        g.ghostImg = g.icon;
      }
    }
    g.update(); 
    g.display();
  }
  
  checkContact();
  displayPoints(); 
  totalPoints = Pacman.getScore();
  if (highScore < totalPoints) highScore = totalPoints;
  displayPoints();
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
      // checks the pathfinding mechanism of ghost
      if (nodeGrid[rows][cols].TREADED == true){
        fill(0, 255, 0); 
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

void checkContact(){ // ISSUE: for some reason, after blue state had been activated once, the ghost disappears from the screen
  for (Ghost g : ghosts){
    if (g.currNode == Pacman.currNode){ 
   //   System.out.println(" this is running " );
       if(!(g.MODE == g.RETURNING) && g.vulnerable ){
          //System.out.println("Ghosts die"); 
          g.reset(); // Right now Pacman is dying even when ghosts are in blue mode
          Pacman.addtoScore(100);
      }
      else if(!(g.MODE == g.RETURNING) && Pacman.reset()) 
        GameOver();
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
