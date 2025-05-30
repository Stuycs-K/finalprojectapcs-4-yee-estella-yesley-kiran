class Ghost extends Characters{
  boolean alive =true;
  boolean vulnerable = false;
  int row; int col; 
  
   Ghost(int startx, int starty, PImage img, Node[][] grid){
     super(startx, starty, img, grid);
   }
   
   void setVulnerable(){
     // change character image to blue weird ghost 
     // change contact thing --> so that they can be eaten    
   }
   
   boolean getVulnerable(){
     return vulnerable;
   }
   
  // void move(int targetx, int targety){
   //}
}
