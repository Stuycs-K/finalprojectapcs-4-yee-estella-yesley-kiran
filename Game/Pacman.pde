class Pacman extends Characters{
  int lives = 3;
  
  Pacman(int startx, int starty, PImage val){
    super(startx, starty, val);
    Pimage value = loadImage("PACMAN.png");
    Image = value; 
  }
  
  void LifeReduction(){
    lives--;
  }
  
  int getLives(){
    return lives;
  }
  
  
}
