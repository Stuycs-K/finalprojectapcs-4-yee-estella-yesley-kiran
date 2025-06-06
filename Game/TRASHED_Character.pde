/* class Characters{
  float Xloc;
  float Yloc;
  int row; 
  int col; 
  PImage Image; 
  boolean moving;
  Node[][] nodegrid;
  float SQUARESIZE = 25.0;
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
 boolean move(int dx, int dy){
   // System.out.println("dx: " + dx + ", dy: " + dy);
    //System.out.println(String.format("Xloc: %.2f, Yloc: %.2f", Xloc, Yloc));
    float newXloc = Xloc + dx * SQUARESIZE/10;
    float newYloc = Yloc + dy * SQUARESIZE/10;
    int newrow =  (int)(newYloc / SQUARESIZE) ; 
    int newcol = (int)(newXloc / SQUARESIZE) ; 
    if(newcol < 0){
      newcol =20;
      Xloc = 21 * SQUARESIZE;
      return true;
    }
    if( nodegrid[newrow][newcol] == null){ 
        System.out.println(String.format("STOP: %.2f, Yloc: %.2f", Xloc, Yloc));
        return false;
    }
    Xloc = newXloc;
    Yloc = newYloc;
    row = newrow;
    col = newcol;
    currNode = nodegrid[row][col];
    return true;
   // Node newNode = null;
    //if ( nodegrid[row][col] != null)  newNode= nodegrid[row][col]; 
    //if (newNode != null && Yloc <= newNode.getY() + 5 && Yloc >= newNode.getY() - 5 && Xloc <= newNode.getX() + 5 && Xloc >= newNode.getX() - 5){
      // currNode = newNode; 
    }
    
 //   println("Xloc:", Xloc, "Yloc:", Yloc, "row:", row, "col:", col);

  
  
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
*/
