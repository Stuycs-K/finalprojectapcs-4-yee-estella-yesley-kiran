class Pointfield{
  private Point[][]field;
  private static final int FRUIT = 100;
  private static final int PELLET = 10;
  private static final int SUPERPELLET = 50;
  private static final int SPACE = 0; 
  private static final int WALL = -1;
  
  public Pointfield(int height, int width){
    for(int row = 0; row < height; row++){
      for(int col =0; col < width; col++){
        //create maze
        //create other values as well!
      }
    }
  }
  
  public Point[][] getField(){
    return field; 
  }
  
   public void carveMaze(int row, int col){
    map[row][col] = WALL; 

    ArrayList<int[]> dir = new ArrayList<int[]>(); 
    dir.add(new int[] {1, 0}); 
    dir.add(new int[] {-1, 0});
    dir.add(new int[] {0, -1}); 
    dir.add(new int[] {0, 1}); 

    while (dir.size()>0){
      int nextDir = (int)(Math.random() * dir.size()); 
      int[] step = dir.remove(nextDir); 

      int nextRow = row + step[0]; 
      int nextCol = col + step[1];       
      if (canCarve(nextRow, nextCol)){
        carveMaze(nextRow, nextCol);
      }
    }
  }
  
   public boolean canCarve(int row, int col) {
    if (row < 1 || row >= map.length-1 || col < 1 || col >= map[0].length-1){
      return false; 
    }
    if (map[row][col] != SPACE){
      return false; 
    }
    int neighbors = 0; 
    int dir[][] = {{1, 0}, {-1, 0}, {0, -1}, {0, 1}}; 
    for (int step = 0; step < 4; step ++){
      int nextRow = row + dir[step][0]; 
      int nextCol = col + dir[step][1]; 
      if (nextRow > 0 && nextRow < map.length - 1 && nextCol > 0 && nextCol < map[0].length - 1) {
        if (map[nextRow][nextCol] == TREE){
          neighbors ++; 
        }
      }
    }
    return (neighbors < 2); 
  }
  
}
