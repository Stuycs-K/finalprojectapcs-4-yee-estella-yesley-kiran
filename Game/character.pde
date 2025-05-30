class character{
  Node currNode; 
  float x, y;
  int dir;
  PImage icon; 
  float speed = 1.5; 
  
 character(Node startNode, PImage img){
   currNode = startNode; 
   x = currNode.x; 
   y = currNode.y; 
   icon = img;
 }
 
 // updates the characters x and y and node only once it's in the center of the node
 void inch(){
   float nodeX = currNode.x; 
   float nodeY = currNode.y; 
   if (abs(x - nodeX) <= 0.1 || abs(y - nodeY) <= 0.1){
     x = nodeX; 
     y = nodeY; 
   }
   else {
     float dx = nodeX - x; 
     float dy = nodeY - y; 
     float dist = sqrt(dx*dx + dy*dy); 
     x += (dx/dist) * speed; 
     y += (dy/dist) * speed; 
   }
 }
 
 void move(int dr, int dc){
  /* int[][] directions = {
    {-1,  0},  // Up
    { 1,  0},  // Down
    { 0, -1},  // Left
    { 0,  1}   // Right
    };
  */
   for (Node neighbor : currNode.neighbors){ // check through all the neighbors to find the right one to move to
     if (neighbor.row - currNode.row == dr && neighbor.col - currNode.col == dc){
       currNode = neighbor; 
     }
   }
 }
 
 void display(){
   image(icon, x, y);
   fill(255); 
   text("x: " + x + "y: " + y, x, y); 
 }
}
