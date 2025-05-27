int[][] map; 
int SQUARESIZE = 25; 
ArrayList<Node> nodes = new ArrayList<Node>();
Node[][] nodeGrid;
Ghost[] ghosts = new Ghost[1]; // change to 4 later
Pacman main; 
int totalPoints = 0; 
int highScore = totalPoints; 

// setup the map, value of -1 is a wall, value of 1 is a point, value of 0 is an empty space
void setup(){
  size(21*25, 21*25);
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
  {-1, -1,  1, -1,  1,  1,  1,  0, -1,  0,  0,  0, -1,  0, -1,  1,  1, -1, -1, -1, -1},
  {-1,  1,  1, -1,  1, -1, -1,  0, -1, -1, -1, -1, -1,  0, -1, -1,  1, -1,  1, -1, -1},
  {-1,  1,  1,  1,  1, -1, -1,  0,  0,  0,  0,  0,  0,  0, -1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1,  1,  1,  1,  1, -1, -1,  1, -1, -1,  1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1, -1, -1,  1, -1, -1,  1, -1,  1, -1,  1,  1,  1, -1},
  {-1,  1, -1, -1,  1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1,  1, -1,  1,  1,  1, -1, -1,  1, -1,  1,  1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  1,  1, -1, -1, -1,  1, -1, -1,  1, -1, -1, -1,  1, -1}, 
  {-1,  1, -1,  1, -1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
    };    
    
  genNodes(); 
  connectNodes(); 
  
  PImage redghost = loadImage("RedGhost.png");
  ghosts[0] = new Ghost(9 * SQUARESIZE, 11 * SQUARESIZE, redghost, nodeGrid); 
  PImage pacimg = loadImage("PACMAN.png");
  main = new Pacman(11 * SQUARESIZE, 11 * SQUARESIZE, pacimg, nodeGrid); 
}  

//creating nodes and stuff:
boolean isWalkable(int r, int c){
  return r >= 0 && r <map.length && c < map[0].length && c >= 0 && map[r][c] == 0;
}

void genNodes(){
  nodeGrid = new Node[map.length][ map[0].length];
  
  for( int r = 0; r < map.length; r++){
    for(int c = 0; c < map[0].length; c++){
      if( map[r][c] >= 0){
        Node n = new Node(r, c, map[r][c]);
        nodes.add(n);
        /* 
        int exits = 0;
        if(isWalkable(r-1, c)) exits++; // up
        if(isWalkable(r+1, c)) exits++; //down
        if(isWalkable(r, c-1)) exits++; //left
        if(isWalkable(r, c+1)) exits++; //right
        
        if (exits != 2 || (isWalkable(r-1, c) && isWalkable(r+1, c)) || (isWalkable(r, c-1) && isWalkable(r, c+1))){
          Node n = new Node(r,c);
          nodes.add(n);
        } 
        */
      }
    }
  }
}

void connectNodes(){
  for(Node n: nodes){
    int r = n.getRow();
    int c = n.getCol();
    int[][] dir = { {0, 1} , {0, -1} , {1,0} , {-1, 0}};
    //up 
    for( int i = 0 ; i < dir.length; i++){
      if(nodeGrid[r + dir[i][0] ][c + dir[0][i]] != null) n.addNeighbor( nodeGrid[r + dir[i][0] ][c + dir[0][i]]);
    }
    
    
    
    /*
    // up
    for (int i = r - 1; i >= 0; i--) {
      if (map[i][c] == 1) break;
      if (nodeGrid[i][c] != null) {
        n.addNeighbor(nodeGrid[i][c]);
        break;
      }
    }

    // down
    for (int i = r + 1; i < map.length; i++) {
      if (map[i][c] == 1) break;
      if (nodeGrid[i][c] != null) {
        n.addNeighbor(nodeGrid[i][c]);
        break;
      }
    }

    // left
    for (int j = c - 1; j >= 0; j--) {
      if (map[r][j] == 1) break;
      if (nodeGrid[r][j] != null) {
        n.addNeighbor(nodeGrid[r][j]);
        break;
      }
    }

    // right
    for (int j = c + 1; j < map[0].length; j++) {
      if (map[r][j] == 1) break;
      if (nodeGrid[r][j] != null) {
        n.addNeighbor(nodeGrid[r][j]);
        break;
      }
    }
    */
  }
}

// POINT SYSTEM 
void calcPoints(){
  
}

void displayPoints(){
  stroke(0); 
  System.out.println("High Score: " + highScore); 
  System.out.println("Current Score: " + totalPoints); 
}

void draw(){
  background(0); 
  drawSquares(map);
  
  main.display(); 
  for (Ghost g : ghosts){
    g.display(); 
  }
  displayPoints(); 
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
          circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/4); 
        }
      }
    }
  }
}

// Check for ^ v < > keys and move Pacman accordingly 
void keyPressed(){
  if (key == CODED){
    if (keyCode == UP) {
      main.move(0, -1);
    } else if (keyCode == DOWN) {
      main.move(0, 1);
    } else if (keyCode == RIGHT) {
      main.move(1, 0); 
    } else {
      main.move(-1, 0); 
    }
  }
}
