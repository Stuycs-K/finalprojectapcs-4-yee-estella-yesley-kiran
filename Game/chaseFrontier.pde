import java.util.*; 

public class chaseFrontier{
  private ArrayDeque<Node> frontier;
  
  
  public chaseFrontier(){
    frontier = new ArrayDeque<Node>(); 
  }
  
  public int size(){
    return frontier.size(); 
  }
  public void add(Node node){
    Node location = nodeGrid[node.row][node.col]; 
    frontier.addLast(location); 
  }
  public Node remove(){
    return frontier.removeFirst(); // QUEUE 
  }
}
