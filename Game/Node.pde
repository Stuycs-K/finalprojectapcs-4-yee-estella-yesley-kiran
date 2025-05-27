class Node{
  private int row;
  private int col;
  private ArrayList<Node> neighbors = new ArrayList<Node>();
  int SQUARESIZE = 25;
  
  Node(int r, int c){
    row = r;
    col =c;
  }
  
  void addNeighbor(Node n){
    neighbors.add(n);
  }
  
  int getRow(){
   return row; 
  }
  
  int getCol(){
    return col;
  }
  
  ArrayList<Node> getNeighbors(){
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
}
