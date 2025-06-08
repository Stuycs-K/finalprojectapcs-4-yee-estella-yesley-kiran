public class Blinky extends Ghost{
 
  public Blinky(Node start, Node target, PImage img, ArrayList<Node> nodesArray){
    super(start, target, img, nodesArray); 
  }
  
  void setTarget(Node targ){
    super.setTarget(targ); 
    // System.out.println("Blinky's target: " + target); 
  }

}
