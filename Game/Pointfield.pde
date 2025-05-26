class Pointfield{
  private int[][]field;
  private static final int FRUIT = 100;
  private static final int PELLET = 10;
  private static final int SUPERPELLET = 50;
  private static final int SPACE = 0; 
  private static final int WALL = -1;
  
  public Pointfield(int height, int width){
    field = new int[][]{
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1, -1,  1,  1, -1,  1, -1,  1, -1,  1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1, -1,  1,  1,  1,  1, -1,  1,  1,  1,  1, -1,  1,  1,  1, -1},
  {-1, -1, -1,  1, -1, -1, -1, -1,  0, -1,  0, -1, -1, -1, -1,  1, -1, -1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1, -1,  1, -1, -1,  0, -1, -1,  1, -1, -1, -1, -1, -1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  1,  1,  0,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1, -1,  1, -1, -1, -1, -1, -1, -1, -1,  1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1, -1,  1,  1,  0,  1,  1, -1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1,  1, -1, -1, -1,  0, -1, -1, -1,  1, -1, -1, -1, -1, -1},
  {-1,  1,  1,  1,  1,  1,  1, -1,  1,  1,  1, -1,  1,  1,  1,  1,  1,  1, -1},
  {-1,  1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  1, -1},
  {-1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1},
  {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
    };     
  }
  
  public int[][] getField(){
    return field; 
  }
/*
  public void carveMaze(int row, int col){
    Point a = new Point(row,col, WALL);
    field[row][col] = a; 

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
    if (row < 1 || row >= field.length-1 || col < 1 || col >= field[0].length-1){
      return false; 
    }
    if (field[row][col].getValue() == WALL){
      return false; 
    }
    int neighbors = 0; 
    int dir[][] = {{1, 0}, {-1, 0}, {0, -1}, {0, 1}}; 
    for (int step = 0; step < 4; step ++){
      int nextRow = row + dir[step][0]; 
      int nextCol = col + dir[step][1]; 
      if (nextRow > 0 && nextRow < field.length - 1 && nextCol > 0 && nextCol < field[0].length - 1) {
        if (field[nextRow][nextCol].getValue() == WALL){
          neighbors ++; 
        }
      }
    }
    return (neighbors < 2); 
 }
 */
  
}
