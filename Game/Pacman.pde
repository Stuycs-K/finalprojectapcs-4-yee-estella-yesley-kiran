class Pacman extends Characters{
  int lives = 3;
  
  Pacman(int startx, int starty, PImage img){
    super(startx, starty, img);
  }
  
  void LifeReduction(){
    lives--;
  }
  
  int getLives(){
    return lives;
  }
  
}
