class Node{
  private int x;
  private int y;
  private int r; 
  private int c; 
  private ArrayList<Node> neighbors = new ArrayList<Node>();
  int value = 0; 
  boolean eaten;
  
  Node(int row, int col, int val){
    x = col* SQUARESIZE + SQUARESIZE/2;
    y = row * SQUARESIZE + SQUARESIZE/2;
    r = row; 
    c = col; 
    value = val; 
    eaten = false;
  }
  
  public void addNeighbor(Node n){
    neighbors.add(n);
  }
  
  public int getX(){
   return y; 
  }
  
  public int getY(){
    return x;
  }
  
  public int getRow(){
    return r;
  }
  
  public int getCol(){
    return c; 
  }
  
  public ArrayList<Node> getNeighbors(){
    return neighbors;
  }
  
  void displayNodes(){
    fill(255,0,0);
    circle(x, y, SQUARESIZE/4); 
  }
  
  void displayEdges(){
    stroke(0,200,0);
    for(Node n: neighbors){
      line(x, y, n.x, n.y);
    }
  }
  

  public void setValue(int val){
    value = val; 
  }
  
  public int getValue(){
    return value; 
  }
  
  public boolean getEaten(){
    return eaten;
  }
  
  public void beEaten(){
    eaten = true;
  }
  
  //public String toString(){
  //  return "" + row + ", " + col + " , " + value;
  //}
  
}
