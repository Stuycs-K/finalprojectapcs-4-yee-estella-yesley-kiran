/* class Pacman extends Characters{
  int lives = 3;
  boolean up =false;
  boolean down = false;
  boolean right = false;
  boolean left = false; 
  int score = 0;
  
  PImage pacUp, pacDown, pacRight, pacLeft; 
  
  Pacman(int startx, int starty, PImage img, Node[][] grid){
    super(startx, starty, img,grid);
     pacRight = loadImage("PacRight.png");       
     pacLeft = loadImage("PacLeft.png");      
     pacUp = loadImage("PacUp.png");   
     pacDown = loadImage("PacDown.png");
  }
  
  void LifeReduction(){
    lives--;
  }
  
  int getLives(){
    return lives;
  }
  
  void setImage(PImage img){
    //PImage result =  ill do this later
    Image = img; 
  }
  
  // wait isn't the point of the arraylist of neighbors so we don't have to check each time? It just continuously moves through or wtv...
  void PacMove(){
    //if( currNode == null) up = down = left = right =false;
    if (up){
      //if(nodegrid[currNode.getRow() - 1][currNode.getCol() ] != null){
        if(!move(0, -1)) up =false;
        Image = pacUp; 
      //}
      //else up = false;
    }
    if (down){
      if( nodegrid[currNode.getRow() + 1][currNode.getCol()] != null){
        move(0, 1);
        Image = pacDown;
      }
      else down = false;
    }
    if (left){
      //if(nodegrid[currNode.getRow()][currNode.getCol() - 1] != null){
      //if(Xloc != currNode.getX()){
        if(!move(-1, 0)) left = false;
        Image = pacLeft; 
      //}
      //else left = false;
    }
    if (right){
      if(nodegrid[currNode.getRow()][currNode.getCol() + 1 ] != null){
        move(1, 0);
        Image = pacRight; 
      }
      else right = false;
    }
    //eating nodes
    
     if(currNode != null && !currNode.getEaten() && currNode.getValue() == 1){
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
        System.out.println( possibles.get(i).getY() + "" + Yloc);
        if(possibles.get(i).getRow() == currNode.getRow() + 1 && possibles.get(i).getY() == Yloc ){
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
*/
