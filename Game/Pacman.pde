class Pacman extends Characters{
  int lives = 3;
  
  Pacman(int startx, int starty, PImage img){
    super(startx, starty, img);
    PImage value = loadImage("PACMAN.png");
    Image = value; 
  }
  
  void LifeReduction(){
    lives--;
  }
  
  int getLives(){
    return lives;
  }
  
}
