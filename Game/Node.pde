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
  
  public void setValue(int val){
    value = val; 
  }
  
  public int getValue(){
    return value; 
  }
}
