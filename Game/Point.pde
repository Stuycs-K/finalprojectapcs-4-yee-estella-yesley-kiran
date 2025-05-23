class Point{
  private int Xval;
  private int Yval;
  private boolean eaten;
  private static final int FRUIT = 100;
  private static final int PELLET = 10;
  private static final int SUPERPELLET =50;
  private static final int WALL = -1;
  
  public Point(int x,int y){
    Xval =x;
    Yval = y;
    eaten = false;
    
  }
  
  public void setEaten(boolean bool){
    eaten = bool;
  }
  
  public int getX(){
    return Xval;
  }
 
  public int getY(){
    return Yval;
  }
  
  public boolean geteaten(){
     return eaten; 
  }
  
}
