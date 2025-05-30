class character{
  Node currNode; 
  float x, y;
  int dir; 
  float speed = 2.5; 
  
 character(Node startNode){
   currNode = startNode; 
   x = currNode.x; 
   y = currNode.y; 
 }
 
 // updates the characters x and y and node only once it's in the center of the node
 void center(){
   float nodeX = currNode.x; 
   float nodeY = currNode.y; 
   if (abs(x - nodeX) <= 0.1 || abs(y - nodeY) <= 0.1){
     x = nodeX; 
     y = nodeY; 
   }
 }
 
 void move(int dir){
   int[][] directions = {
    {-1,  0},  // Up
    { 1,  0},  // Down
    { 0, -1},  // Left
    { 0,  1}   // Right
    };
   for (Node neighbor : currNode.neighbors){
     int nextRow = neighbor.row - currNode.row; 
     int nextCol = neighbor.col - currNode.col; 
   }
 }
}
