class Node{
  private int row;
  private int col;
  private ArrayList<Node> neighbors = new ArrayList<Node>();
  
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
  
}
