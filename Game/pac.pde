class pac extends character{
  boolean UP =false;
  boolean DOWN = false;
  boolean RIGHT = false;
  boolean LEFT = false; 
  int score = 0;
  int lives = 3;
 
  PImage pacUp, pacDown, pacRight, pacLeft; 
  
  pac(Node startNode, PImage img){
    super(startNode, img);
     pacRight = loadImage("PacRight.png");       
     pacLeft = loadImage("PacLeft.png");      
     pacUp = loadImage("PacUp.png");   
     pacDown = loadImage("PacDown.png");
  }
  
  void display(){
  }
  
  void center(){
    super.center(); 
    if (abs ( x - currNode.x) < 0.1 && abs(y - currNode.y) < 0.1){
      changeDir(); 
    }
  }
  
  void changeDir(){
    if (UP) move(-1, 0);  
    else if (DOWN) move (1, 0); 
    else if (LEFT) move (0, -1); 
    else if (RIGHT) move (0, 1); 
  }
  
  void subHealth(){
    lives--;
  }
  
  int getLives(){
    return lives;
  }
}
