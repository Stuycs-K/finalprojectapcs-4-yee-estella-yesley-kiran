class Characters{
  int Xloc;
  int Yloc;
  PImage Image; 
  boolean moving;
  Node[][] nodegrid;
  int SQUARESIZE = 25;
  
  Characters(int startX, int startY, PImage img, Node[][] grid){
      Xloc = startX;
      Yloc = startY;
      Image = img;
      moving = false;
      nodegrid =grid;
  }
  
 void move(int dx, int dy){
    Xloc += dx * 5;
    Yloc += dy * 5;
  }
  
  int[] currLocation(){
    int[] ans = {Xloc, Yloc};
    return ans;
  }
  
  int getX(){
    return Xloc;
  }
  
  int getY(){
    return Yloc; 
  }
  
  void display(){
    image(Image, Xloc, Yloc);
  }
  
  boolean getMove(){
    return moving;
  }
  
  
}
