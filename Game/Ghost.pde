class Ghost extends Characters{
  boolean alive =true;
  boolean vulnerable = false;
  PVector target;  
  int row; int col; 
  
   Ghost(int startx, int starty, PVector pacpos, PImage img, Node[][] grid){
     super(startx, starty, img, grid);
     target = pacpos; 
   }
   
   void setVulnerable(){
     // change character image to blue weird ghost 
     // change contact thing --> so that they can be eaten    
   }
   
   boolean getVulnerable(){
     return vulnerable;
   }
   
   void chase(){
     
   }
   
  // void move(int targetx, int targety){
   //}
}
