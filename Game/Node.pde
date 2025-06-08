class Node{
  float x, y;
  int row, col; 
  private ArrayList<Node> neighbors = new ArrayList<Node>();
  int value = 0; 
  boolean eaten;
  
  int seq = 0; 
  boolean TREADED = false;
  Node parent = null; 
  
  boolean pathPart = false; 
  
  Node(int r, int c,  int val){
    row = r; 
    col = c; 
    x = col* SQUARESIZE;
    y = row * SQUARESIZE;
    value = val; 
    eaten = false;
  }
  
  public void addNeighbor(Node n){
    neighbors.add(n);
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
  
  public boolean equals(Node other){
    return (row == other.row && col == other.col);
  }
  
  public String toString(){
    return "" + row + ", " + col + " , " + value;
  }
  
}
