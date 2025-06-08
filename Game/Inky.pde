public class Inky extends Ghost{

  public Inky(Node start, Node target, PImage img){
      super(start, target, img); 
    }
    
  void setTarget(){ // chooses the node 180 degrees from where the red's position is
    Node redPos = blinky.currNode; 
    int targRow = redPos.col; 
    int targCol = redPos.row; 
    if (nodeGrid[targRow][targCol] != null){
      target = nodeGrid[targRow][targCol]; 
    }
    else {
      int[][] dir = {
        {-1, 0}, {1, 0}, {0, -1}, {0, 1}
      }; 
      for (int i = 0; i < dir.length; i ++){
        int nextR = targRow + dir[i][0]; 
        int nextC = targCol + dir[i][1]; 
        if (nodeGrid[nextR][nextC] != null){
          target = nodeGrid[nextR][nextC]; 
        }
      }
    }
    System.out.println("Inky's target: " + target); 
  }
  
  
}
