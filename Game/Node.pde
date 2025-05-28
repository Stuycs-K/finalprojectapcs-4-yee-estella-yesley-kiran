class Node{
  private int row;
  private int col;
  private ArrayList<Node> neighbors = new ArrayList<Node>();
  int value = 0; 
  
  Node(int r, int c, int val){
    row = r;
    col = c;
    value = val; 
  }
  
  public void addNeighbor(Node n){
    neighbors.add(n);
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
    circle(col * SQUARESIZE + SQUARESIZE/2, row * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/4); 
  }
  
  void displayEdges(){
    stroke(0,200,0);
    for(Node n: neighbors){
      line(col * SQUARESIZE + SQUARESIZE/2, row * SQUARESIZE + SQUARESIZE/2 , n.col * SQUARESIZE + SQUARESIZE/2 , n.row * SQUARESIZE + SQUARESIZE/2);
    }
  }
  
  public void setValue(int val){
    value = val; 
  }
  
  public int getValue(){
    return value; 
  }
  
}
