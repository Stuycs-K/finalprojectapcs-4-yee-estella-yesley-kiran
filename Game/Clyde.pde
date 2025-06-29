public class Clyde extends Ghost{

  public Clyde(Node start, Node target, PImage img){
      super(start, target, img); 
    }
    
  private float distanceToTarget(Node node) {
    float dx = node.row - target.row;
    float dy = node.col - target.col;
    return (float) Math.sqrt(dx * dx + dy * dy);
  }
  
  void setTarget(Node targ){
    if (distanceToTarget(targ) > 8){
      super.setTarget(targ); 
    }
    else {
      ArrayList<Node> neighbors = new ArrayList<>(currNode.getNeighbors());
      if (prevNode != null && neighbors.size() > 1)
        neighbors.remove(prevNode); 
      if (neighbors.size() <= 0)
        target = currNode; 
      else {
        int select = (int) random(neighbors.size()); 
        target = neighbors.get(select); 
      }
    }
  }
  
}
