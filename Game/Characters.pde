class Characters{
  int Xloc;
  int Yloc;
  int row; 
  int col; 
  PImage Image; 
  boolean moving;
  Node[][] nodegrid;
  int SQUARESIZE = 25;
  Node currNode; 
  
  Characters(int startRow, int startCol, PImage img, Node[][] grid){
      // Xloc = startX;
      // Yloc = startY;
      row = startRow; 
      col = startCol; 
      Xloc = col * SQUARESIZE; 
      Yloc = row * SQUARESIZE; 
      Image = img;
      moving = false;
      nodegrid = grid;
      // currNode = nodegrid[startX / SQUARESIZE ][ startY / SQUARESIZE];
      currNode = nodegrid[startRow][startCol]; 
  }
  
 // Incremenet int by row and colum, why divide by squaresize 
 void move(int dx, int dy){
    Xloc += dx * 3;
    Yloc += dy * 3;
    //int appX = Xloc / SQUARESIZE;
    //int appY = Yloc / SQUARESIZE;
    //currNode = nodegrid[appY][appX];
    row = Yloc / SQUARESIZE ; 
    col = Xloc / SQUARESIZE ; 
    currNode = nodegrid[row][col]; 
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
  
  String toString(){
    return currNode.toString();
  }
  
}
