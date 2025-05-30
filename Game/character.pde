class character{
  Node currNode; 
  Node nextNode; 
  float x, y;
  int dir;
  PImage icon; 
  float speed = 0.8; 
  
 character(Node startNode, PImage img){
   currNode = startNode; 
   x = currNode.x; 
   y = currNode.y; 
   icon = img;
 }
 
 // updates the characters x and y and node only once it's in the center of the node
 void inch(){
   //move(dy, dx); 
   //x += dx * SQUARESIZE/4; 
   //y += dy * SQUARESIZE/4; 
   if (nextNode != null){
     float dx = nextNode.x - x; 
     float dy = nextNode.y - y; 
     float dist = sqrt(dx*dx + dy*dy); 
     if (dist > 0){
       x += (dx/dist) * speed; 
       y += (dy/dist) * speed; 
     }
     if (abs(x - nextNode.x) <= 0.1 || abs(y - nextNode.y) <= 0.1){
       currNode = nextNode; 
       x = currNode.x; 
       y = currNode.y; 
     }
   }
 }
 
 void move(int dr, int dc){
   for (Node neighbor : currNode.neighbors){ // check through all the neighbors to find the right one to move to
     if (neighbor.row == currNode.row + dr && neighbor.col == currNode.col + dc){
       nextNode = neighbor; 
     }
     if (neighbor.row == 10 && neighbor.col == 0){
       nextNode = neighbor; 
     }
     if (neighbor.row == 10 && neighbor.col == map.length-1){
       nextNode = neighbor; 
     }
   }
 }
 
 void display(){
   image(icon, x, y);
   fill(255); 
   text("x: " + x + "y: " + y, x, y); 
   // text("speed: " + speed, x, y  + 15);
 }
}
