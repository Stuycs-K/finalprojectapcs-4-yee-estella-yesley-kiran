int[][] map; 
int SQUARESIZE; 

// setup the map, value of -1 is a wall, value of 1 is a point, value of 0 is an empty space
void setup(){
  size(1000, 1000); 
<<<<<<< HEAD
  map = new int[][]{
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1, -1,  1,  1, -1,  1, -1,  1, -1,  1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1, -1,  1,  1,  1,  1, -1,  1,  1,  1,  1, -1,  1,  1,  1, -1},
  {-1, -1, -1,  1, -1, -1, -1, -1,  0, -1,  0, -1, -1, -1, -1,  1, -1, -1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1, -1,  1, -1, -1,  0, -1, -1,  1, -1, -1, -1, -1, -1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1, -1,  1, -1, -1, -1, -1, -1, -1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1, -1,  1,  1,  0,  1,  1, -1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1,  1, -1, -1, -1,  0, -1, -1, -1,  1, -1, -1, -1, -1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
    };    
  
  SQUARESIZE = height / map.length; 

=======
  ROWS = 25; 
  COLS = 25; 
  map = new Pointfield(ROWS, COLS); 
  SQUARESIZE = width / COLS; 
>>>>>>> c9c95fc0b5ce450450a281d5a6d6c37482ff54e4
}  

void draw(){
  background(0); 
  drawSquares(map);
}

/* Draw the walls, points, etc 
For later: 
 - add in different pixels for each fruit/point 
 - make this actually look good 
*/ 
<<<<<<< HEAD
void drawSquares(int[][] map){
  for (int rows = 0; rows < map.length; rows ++){
    for (int cols = 0; cols < map.length; cols ++){
      if(map[rows][cols] < 0){
=======
void drawSquares(Pointfield map){
  for (int rows = 0; rows < ROWS; rows ++){
    for (int cols = 0; cols < COLS; cols ++){
      if(map.field[rows][cols] >= 0){
>>>>>>> c9c95fc0b5ce450450a281d5a6d6c37482ff54e4
        fill (0, 0, 255); 
        rect(cols * SQUARESIZE, rows * SQUARESIZE, SQUARESIZE, SQUARESIZE); 
      }
      else {
        fill (255); 
        circle(cols * SQUARESIZE + SQUARESIZE/2, rows * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/4); 
      }
    }
  }
}

// Check for ^ v < > keys and move Pacman accordingly 
void keyPressed(){
  
}
