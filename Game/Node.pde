class Node{
  private int row;
  private int col;
  private ArrayList<Node> neighbors = new ArrayList<Node>();
<<<<<<< HEAD
  int SQUARESIZE = 25;
=======
  int value = 0; 
>>>>>>> 792fe030bfcf113f16633f03f0d8a7966900966e
  
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
  
<<<<<<< HEAD
  void displayNodes(){
    fill(255,0,0);
    circle(col * SQUARESIZE + SQUARESIZE/2, row * SQUARESIZE + SQUARESIZE/2, SQUARESIZE/4); 
  }
  
  void displayEdges(){
    stroke(0,200,0);
    for(Node n: neighbors){
      line(col * SQUARESIZE + SQUARESIZE/2, row * SQUARESIZE + SQUARESIZE/2 , n.col * SQUARESIZE + SQUARESIZE/2 , n.row * SQUARESIZE + SQUARESIZE/2);
    }
=======
  public void setValue(int val){
    value = val; 
  }
  
  public int getValue(){
    return value; 
>>>>>>> 792fe030bfcf113f16633f03f0d8a7966900966e
  }
}
