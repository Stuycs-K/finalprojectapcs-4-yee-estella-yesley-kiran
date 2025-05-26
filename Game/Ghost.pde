class Ghost extends Characters{
  boolean alive =true;
  boolean vulnerable = false;
  
   Ghost(int startx, int starty, PImage img){
     super(startx, starty, img);
   }
   
   void setVulnerable(){
     // change character image to blue weird ghost 
     // change contact thing --> so that they can be eaten    
   }
   
   boolean getVulnerable(){
     return vulnerable;
   }
}
