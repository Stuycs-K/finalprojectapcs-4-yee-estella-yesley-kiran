class Node{
  int row;
  int col;
  ArrayList<Node> neighbors = new ArrayList<Node>();
  
  Node(int r, int c){
    row = r;
    col =c;
  }
  
  void addNeighbor(Node n){
    neighbors.add(n);
  }
}
