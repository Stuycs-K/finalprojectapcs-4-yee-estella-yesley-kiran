import java.util.*; 

public class chaseFrontier{
  private ArrayDeque<int[]> frontier;
  
  
  public chaseFrontier(){
    frontier = new ArrayDeque<int[]>(); 
  }
  
  public int size(){
    return frontier.size(); 
  }
  public void add(Node node){
    int[] location = new int[]{node.row, node.col}; 
    frontier.addLast(location); 
  }
  public int[] remove(){
    return frontier.removeFirst(); // QUEUE 
  }
}
