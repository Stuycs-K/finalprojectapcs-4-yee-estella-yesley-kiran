class Point{
  private int Xval;
  private int Yval;
  private boolean eaten;
  private int value;
  
  public Point(int x,int y, int val){
    Xval =x;
    Yval = y;
    eaten = false;
    value = val;
    
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
  
  public int getValue(){
    return value; 
  }
  
  public boolean geteaten(){
     return eaten; 
  }
  
  
}
