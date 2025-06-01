int[][] map; 
int SQUARESIZE = 25; 

ArrayList<Node> nodes = new ArrayList<Node>();
Node[][] nodeGrid;

Ghost[] ghosts = new Ghost[1]; // change to 4 later
//Pacman main; 
pac Pacman; 

int totalPoints = 0; 
int highScore = totalPoints; 

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
  {-1,  1, -1, -1,  1, -1, -1, -1, -1, -1,  1, -1, -1,  1, -1,  1, -1,  1,  1,  1, -1},
  {-1,  1, -1, -1,  1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1,  1, -1, -1, -1,  1, -1},
  {-1,  1, -1, -1,  1, -1, -1, -1,  1, -1,  1,  1,  1, -1, -1,  1, -1,  1,  1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  1,  1, -1, -1, -1,  1, -1, -1,  1, -1, -1, -1,  1, -1}, 
  {-1,  1, -1,  1, -1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
    };    
    
  genNodes(); 
  connectNodes(); 
  
  // main = new Pacman(10 * SQUARESIZE, 13 * SQUARESIZE,pacimg, nodeGrid); 
  PImage pacman = loadImage("PacRight.png");       
  //main = new Pacman(13, 10, pacman, nodeGrid); 
  //position = new PVector(main.row, main.col); 
  Node start = nodeGrid[13][10]; 
  Pacman = new pac(start, pacman); 
  PImage redghost = loadImage("RedGhost.png");
  //ghosts[0] = new Ghost(11, 9, position, redghost, nodeGrid); 
  ghosts[0] = new Ghost(nodeGrid[11][9], nodeGrid[9][10], redghost, nodeGrid); 
  
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

public void draw(){
  background(0); 
  drawSquares(map);
  //for(Node n: nodes){
  //  n.displayNodes();
  //  n.displayEdges();
  //}
  
  for (Ghost g : ghosts){
    g.setTarget(Pacman.currNode); // MUST CHANGE to account for their different targets leter 
    g.chase(); 
    // g.display(); 
  }
  
  Pacman.inch();
  Pacman.display(); 
  
  displayPoints(); 
  totalPoints = Pacman.getScore();
  if (highScore < totalPoints) highScore = totalPoints;
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
          Node current = nodeGrid[rows][cols];
          if(!current.getEaten())
          circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/4); 
        }
        
      }
    }
  }
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
