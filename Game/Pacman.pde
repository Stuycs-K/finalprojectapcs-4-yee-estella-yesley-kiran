class Pacman extends Characters{
  int lives = 3;
  boolean up =false;
  boolean down = false;
  boolean right = false;
  boolean left = false; 
  
  Pacman(int startx, int starty, PImage img, Node[][] grid){
    super(startx, starty, img,grid);
  }
  
  void LifeReduction(){
    lives--;
  }
  
  int getLives(){
    return lives;
  }
  
  void rotate90(){
    //PImage result =  ill do this later
  }
  
   void changeMoving(){
    if(nodegrid[Xloc / SQUARESIZE][Yloc/SQUARESIZE] != null){
      
    }
  }
  
}
