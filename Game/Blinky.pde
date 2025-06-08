public class Blinky extends Ghost{
 
  public Blinky(Node start, Node target, PImage img){
    super(start, target, img); 
  }
  
  void setTarget(Node targ){
    super.setTarget(targ); 
    // System.out.println("Blinky's target: " + target); 
  }

}
