import processing.sound.*;
int[][] map; 
int SQUARESIZE = 25; 

ArrayList<Node> nodes = new ArrayList<Node>();
Node[][] nodeGrid;

ArrayList<Ghost> ghosts = new ArrayList<Ghost>(); // change to 4 later
PImage redG, purpG, greenG, Blue,Eyes, orangeG, GAMEOVER,cherry; 
Blinky blinky; 
Pinky pinky; 
Inky inky; 
Clyde clyde; 
SoundFile music;
SoundFile deathsfx;

float restartTime = 0; 
Pac Pacman; 
PImage pacman; 

int score = 0; 
int highScore;
boolean gameOver = false; 

boolean fresh = false;
int freshtime =0; //<>//
// setup the map, value of -1 is a wall, value of 1 is a point, value of 0 is an empty space
void setup(){
  size(21*25, 21*25 + 75); 
  map = new int[][]{
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
  {-1, -1, -1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1, -1, -1, -1, -1, -1,  1, -1, -1, -1,  1, -1,  1, -1},
  {-1,  1, -1,  1,  1, -1,  1, -1, -1, -1, -1, -1, -1,  1,  10,  1,  1,  1, -1,  1, -1},
  {-1,  1, -1,  1, -1,  10,  1,  1,  1,  1,  1,  1,  1,  1, -1, -1, -1,  1, -1,  1, -1},
  {-1,  1, -1, -1, -1,  1, -1,  1, -1, -1, -1, -1, -1,  1, -1, -1, -1,  1,  1,  1, -1},
  {-1,  1, -1,  1, -1,  1,  1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1,  1, -1,  1, -1},
  {-1,  1, -1,  1,  1, -1,  1, -1, -1,  1, -1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1,  1, -1,  1,  1, -1,  0, -1, -1,  0, -1, -1,  0, -1, -1, -1,  1, -1, -1, -1},
  { 1,  1,  1, -1, -1,  1, -1,  0, -1,  0,  0,  0, -1,  0,  1,  1,  1,  1,  1,  1,  1},
  {-1, -1,  1, -1,  1,  1,  1,  0, -1,  0,  0,  0, -1,  0, -1,  1, -1, -1, -1, -1, -1},
  {-1,  1,  1, -1,  1, -1, -1,  0, -1, -1, -1, -1, -1,  0, -1,  1, -1, -1,  1,  1, -1},
  {-1,  1,  1,  1,  1, -1, -1,  0,  0,  0,  0,  0,  0,  0, -1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1,  10,  1,  1,  1, -1, -1,  1, -1, -1,  1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1, -1, -1,  1, -1, -1,  1, -1,  1,  1,  1,  1,  10, -1},
  {-1,  1, -1, -1,  1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1,  1, -1,  1,  1,  1, -1, -1,  1,  1,  1,  1,  1, -1},
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
  orangeG = loadImage("OrangeGhost.png");
  Eyes = loadImage("DeadGhostEyes.png");
  GAMEOVER = loadImage("GameOver.jpg");
  cherry = loadImage("CHERRY.png");
  
  music = new SoundFile(this, "MUSIC.mp3");
  deathsfx = new SoundFile(this, "Pac-Man Death.mp3"); 
  
  
  
  blinky = new Blinky(nodeGrid[11][9], nodeGrid[3][19], redG); 
  pinky = new Pinky(nodeGrid[11][10], nodeGrid[3][3], purpG); 
  inky = new Inky(nodeGrid[11][11], nodeGrid[19][3], greenG); 
  clyde = new Clyde(nodeGrid[10][11], nodeGrid[19][19], orangeG); 
  
  ghosts.add(blinky); 
  ghosts.add(pinky); 
  ghosts.add(inky); 
  ghosts.add(clyde); 
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
  randomCherry();
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

void randomCherry(){
  int val4 = (int) random(4);
  map[1][13] = map[16][1] = map[19][14] = map[8][19] = 1;
  if(val4 == 0) map[1][16] = 30;
  if(val4 == 1) map[13][1] = 30;
  if(val4 == 2) map[19][14] = 30;
  if(val4 == 3) map[8][19] = 30;
  
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

public void displayPoints(){
  fill(255,255,255);
  textSize(25);
  text("High Score: " + highScore, (21 * 25) /3 , (21 * 25) + 30);
  text( "Current Score: " + score , (21 * 25) /3 , (21 * 25) +55);

}

public void displayLives(){
    fill(255,255,255);
    textSize(25);
    text("Lives : " + Pacman.getLives(),0, (21 * 25) + 30 );

}

public void draw(){
  background(0); 
  drawSquares(map);
  
  Pacman.inch();
  Pacman.display();
  for (Node n : nodes){
    n.pathPart = false; 
  }
  for (Ghost g : ghosts){
    g.timeGhosts(); 
    if (g.MODE == GhostMode.SCATTER){
      if (g == blinky){
        g.target = nodeGrid[3][19]; 
      }
      if (g == pinky){
        g.target = nodeGrid[2][1]; 
      }
      if (g == inky){
        g.target = nodeGrid[19][1]; 
      }
      if (g == clyde){
        g.target = nodeGrid[19][19]; 
      }
    }
    else if (g.MODE == GhostMode.CHASE){
            g.setTarget(Pacman.currNode); 
    }
    else if (g.MODE == GhostMode.RETURNING){
      g.target = nodeGrid[11][10]; 
      g.speed = 5; 
      g.ghostImg = Eyes; 
      if (g.currNode == nodeGrid[11][10]) {
         // the ghost has returned home
        g.MODE = GhostMode.CHASE;
        g.ghostImg = g.icon;
        g.speed = 1.5;
      }
    }
     //<>//
    g.update(); 
    g.display();
  }
  
  
  
  playSounds();
  checkContact();
  checkPoints();
  timers();
  displayPoints(); 
  score = Pacman.getScore();
  if (highScore < score) highScore = score;
  displayPoints();
  displayLives();
}

void playSounds(){
  if(!gameOver){
    if(!music.isPlaying()) music.play();
  }
  else music.pause();

}

void checkPoints(){
  for(Node n: nodes){
    if(n.eaten == false){
      System.out.println(n);
      return;
    }
  }
  // then reset 
    System.out.println("here!!");
  for(Node n: nodes){
    if(n.value > 0) n.eaten = false;
  }
}


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
          if(!current.eaten)
          circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/4); 
        }
        if (map[rows][cols] == 10){
          Node current = nodeGrid[rows][cols];
          if(!current.eaten)
          circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/2); 
        }
        if (map[rows][cols] == 30){
          Node current = nodeGrid[rows][cols];
          if(!current.eaten)
            image(cherry,cols * SQUARESIZE,  rows * SQUARESIZE);
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
        GameOver();
    }
  } //<>//
}

void timers(){
  if (millis() - freshtime > 5000) fresh= false;
}

void GameOver(){
  image(GAMEOVER,0,0);
   music.pause();
   deathsfx.play(); //<>//
  
  gameOver = true; 
  noLoop();
}

void tryAgain(){
  if(gameOver){
  score = 0; 
  
  Pacman = new Pac(nodeGrid[13][10], pacman); 
  for (Node n : nodes){
    if(n.value > 0) n.eaten = false;
  }
  
  ghosts = new ArrayList<Ghost>();
  blinky = new Blinky(nodeGrid[11][9], nodeGrid[3][19], redG); 
  pinky = new Pinky(nodeGrid[11][10], nodeGrid[3][3], purpG); 
  inky = new Inky(nodeGrid[11][11], nodeGrid[19][3], greenG); 
  clyde = new Clyde(nodeGrid[10][11], nodeGrid[19][19], orangeG); 
  
  ghosts.add(blinky); 
  ghosts.add(pinky); 
  ghosts.add(inky); 
  ghosts.add(clyde); 
  for (Ghost g : ghosts){
    g.blueghost = Blue; 
    g.eyesghost = Eyes;
    g.MODE = GhostMode.SCATTER; 
    restartTime = millis(); 
  }
  gameOver = false; 
  loop(); 
  }
}

public void keyPressed(){
   if (gameOver && key == ENTER){ // Press enter to restart
    tryAgain(); 
  }
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
