public class Pinky extends Ghost{
  
  Pinky(Node start, Node target, PImage img){
    super(start, target, img); 
  }
  
  void setTarget(Node targ){ // Targets the node four tiles ahead of Pacman (selects a random node from its valid neighbors)
    Node temp = targ; 
    ArrayList<Node> neighbors = new ArrayList<>(temp.getNeighbors()); 
    if (prevNode != null && neighbors.size() > 0)
      neighbors.remove(prevNode);
    for (int i = 1; i <= 4; i ++){
     neighbors = temp.getNeighbors(); 
     Node prev = temp; 
     neighbors.remove(prev); 
     int select = (int) random(neighbors.size()); 
     temp = neighbors.get(select); 
    }
    target = temp; 
    // System.out.println("Pinky's target: " + target); 
  }
  
  
  
}
