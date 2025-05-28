class Characters{
  int Xloc;
  int Yloc;
  PImage Image; 
  boolean moving;
  Node[][] nodegrid;
  int SQUARESIZE = 25;
  Node currNode; 
  
  Characters(int startX, int startY, PImage img, Node[][] grid){
      Xloc = startX;
      Yloc = startY;
      Image = img;
      moving = false;
      nodegrid =grid;
      currNode = nodegrid[startX / SQUARESIZE][ startY / SQUARESIZE];
  }
  
 void move(int dx, int dy){
    Xloc += dx * 1;
    Yloc += dy * 1;
    int appX = Xloc / SQUARESIZE;
    int appY = Yloc / SQUARESIZE;
    currNode = nodegrid[appX][appY];
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
