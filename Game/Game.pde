Pointfield map; 
int ROWS; 
int COLS; 
int SQUARESIZE; 

void setup(){
  size(1000, 1000); 
  ROWS = 100; 
  COLS = 100; 
  map = new Pointfield(ROWS, COLS); 
  SQUARESIZE = width / COLS; 
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
void drawSquares(Pointfield map){
  for (int rows = 0; rows < ROWS; rows ++){
    for (int cols = 0; cols < COLS; cols ++){
      if(map.field[rows][cols].getValue() < 0){
        fill (0, 0, 255); 
        rect(cols * SQUARESIZE, rows * SQUARESIZE, SQUARESIZE, SQUARESIZE); 
      }
      else {
        fill (255); 
        circle(cols * SQUARESIZE, rows * SQUARESIZE, SQUARESIZE/4); 
      }
    }
  }
}

// Check for ^ v < > keys and move Pacman accordingly 
void keyPressed(){
  
}
