class Ghost extends Characters{
  boolean alive =true;
  boolean vulnerable = false;
  
   Ghosts(int startx, int starty, PImage val){
     super(startx, starty, val);
     Pimage value = loadImage("GhostRed.png"); //for now will deelte later and instead assign in game class
     Image = value; 
   }
   
   void setVulnerable(){
     // change character image to blue weird ghost 
     // change contact thing --> so that they can be eaten 
     
   }
   
   boolean getVulnerable(){
     return vulnerable;
   }
}
