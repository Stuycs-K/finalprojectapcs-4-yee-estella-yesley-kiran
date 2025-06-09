public class Inky extends Ghost{

  public Inky(Node start, Node target, PImage img){
      super(start, target, img); 
    }
    
  void setTarget(Node targ){ 
    Node redPos = blinky.currNode; 
    int targRow = 2 * targ.row - redPos.row; 
    int targCol = 2 * targ.col - redPos.col; 
    
    // making sure it's in bounds 
    targRow = max(0, min(nodeGrid.length -1, targRow)); 
    targCol = max(0, min(nodeGrid[0].length-1, targCol)); 
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
        if (nextR >= 0 && nextR < map.length && nextC >= 0 && nextC < map.length && nodeGrid[nextR][nextC] != null){
          target = nodeGrid[nextR][nextC];
        }

      }
    }

  }
  
  
}
