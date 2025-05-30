class Node{
  float x, y;
  int row, col; 
  private ArrayList<Node> neighbors = new ArrayList<Node>();
  int value = 0; 
  boolean eaten;
  
  Node(int r, int c,  int val){
    x = col* SQUARESIZE + SQUARESIZE/2;
    y = row * SQUARESIZE + SQUARESIZE/2;
    row = r; 
    col = c; 
    value = val; 
    eaten = false;
  }
  
  public void addNeighbor(Node n){
    neighbors.add(n);
  }
  
  public float getX(){
   return x; 
  }
  
  public float getY(){
    return y;
  }
  
  public int getRow(){
    return row;
  }
  
  public int getCol(){
    return col; 
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
  
  public String toString(){
    return "" + row + ", " + col + " , " + value;
  }
  
}
