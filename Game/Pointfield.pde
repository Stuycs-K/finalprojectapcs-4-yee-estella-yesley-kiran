class Pointfield{
  private Point[][]field;
  private static final int FRUIT = 100;
  private static final int PELLET = 10;
  private static final int SUPERPELLET =50;
  private static final int WALL = -1;
  
  public Pointfield(int height, int width){
    for(int row = 0; row < height; row++){
      for(int col =0; col < width; col++){
        //create maze
        //create other values as well!
      }
    }
  }
  
  public Point[][] getField(){
    return field; 
  }
  
}
