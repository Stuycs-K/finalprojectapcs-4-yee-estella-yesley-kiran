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
    Xloc += dx * SQUARESIZE/5.0;
    Yloc += dy * SQUARESIZE/5.0;
    row = (int) (Yloc / SQUARESIZE) ; 
    col = (int) (Xloc / SQUARESIZE) ; 
    Node newNode = nodegrid[row][col]; 
    if (Yloc <= newNode.getY() + 5 && Yloc >= newNode.getY() - 5 && Xloc <= newNode.getX() + 5 && Xloc >= newNode.getX() - 5){
       currNode = newNode; 
    }
    
    println("Xloc:", Xloc, "Yloc:", Yloc, "row:", row, "col:", col);

  }
  
  float[] currLocation(){
    float[] ans = {Xloc, Yloc};
    return ans;
  }
  
  float getX(){
    return Xloc;
  }
  
  float getY(){
    return Yloc; 
  }
  
  void display(){
    image(Image, Xloc, Yloc);
    fill(255); 
    text("x: " + Xloc + "y: " + Yloc, Xloc, Yloc); 
  }
  
  boolean getMove(){
    return moving;
  }
  
  String toString(){
    return currNode.toString();
  }
  
}
