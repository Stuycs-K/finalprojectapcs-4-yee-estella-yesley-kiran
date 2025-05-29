class Pacman extends Characters{
  int lives = 3;
  boolean up =false;
  boolean down = false;
  boolean right = false;
  boolean left = false; 
  int score = 0;
  
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
  
  // wait isn't the point of the arraylist of neighbors so we don't have to check each time? It just continuously moves through or wtv...
  void PacMove(){
    if (up){
      if(nodegrid[currNode.getRow() - 1][currNode.getCol() ] != null){
        move(0, -1);
      }
      else up = false;
    }
    if (down){
      if( nodegrid[currNode.getRow() + 1][currNode.getCol()] != null){
        move(0, 1);
      }
      else down = false;
    }
    if (left){
      if(nodegrid[currNode.getRow()][currNode.getCol() - 1] != null){
        move(-1, 0);
      }
      else left = false;
    }
    if (right){
      if(nodegrid[currNode.getRow()][currNode.getCol() + 1 ] != null){
        move(1, 0);
      }
      else right = false;
    }
    //eating nodes
    
     if(!currNode.getEaten()){
       currNode.beEaten();
       score++;
     }
  }
  
  void PacMove(String val){
    ArrayList<Node> possibles = currNode.getNeighbors();
    if(val.equals("up")){
      for(int i = 0; i < possibles.size(); i++){
        if(possibles.get(i).getRow() == currNode.getRow() - 1){
          up = true;
          down = right= left= false;
        }
      }
    }
    if(val.equals("down")){
      for(int i = 0; i < possibles.size(); i++){
        if(possibles.get(i).getRow() == currNode.getRow() + 1){
          down = true;
          up = right= left= false;
        }
      }
    }
    if(val.equals("right")){
      for(int i = 0; i < possibles.size(); i++){
        if(possibles.get(i).getCol() == currNode.getCol() + 1){
          right = true;
          down = up= left= false;
        }
      }
    }
    if(val.equals("left")){
      for(int i = 0; i < possibles.size(); i++){
        if(possibles.get(i).getCol() == currNode.getCol() - 1){
          left = true;
          down = right= up= false;
        }
      }
    }
  }
  
  public int getScore(){
    return score; 
  }
  
}
