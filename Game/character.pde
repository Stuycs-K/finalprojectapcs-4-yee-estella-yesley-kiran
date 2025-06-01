class character{
  Node currNode; 
  Node nextNode; 
  float x, y;
  // int dir;
  PImage icon; 
  float speed = 2; 
  
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
   System.out.println(nextNode); 
   if (nextNode != null){
     float dx = nextNode.x - x; 
     float dy = nextNode.y - y; 
     float dist = sqrt(dx*dx + dy*dy); 
     if (dist > 0){       
       x += (dx/dist) * speed; 
       y += (dy/dist) * speed; // SPEED DOES NOT WORK!!! Still goes too fast
     }
     // actual updating of the node position 
     if (abs(x - nextNode.x) <= 1 && abs(y - nextNode.y) <= 1){
       currNode = nextNode; 
       x = currNode.x; 
       y = currNode.y; 
     }
   }
 }
 
 void move(int dr, int dc){
  // if(currNode.col + dc < 0) nextNode = nodeGrid[currNode.row][20];
   //else if(currNode.col + dc > 20) nextNode = nodeGrid[currNode.row][0];
   //else{
   for (Node neighbor : currNode.neighbors){ // check through all the neighbors to find the right one to move to
     if (neighbor.row == currNode.row + dr && neighbor.col == currNode.col + dc){
       nextNode = neighbor; 
     }
   }
     /*
     if (neighbor.row == 10 && neighbor.col == 0){
       nextNode = nodeGrid[10][map.length-2]; 
     }
     if (neighbor.row == 10 && neighbor.col == map.length-1){
       nextNode = nodeGrid[10][1]; 
     }
     */
 //  }
 }
 
 void display(){
   image(icon, x, y);
   fill(255); 
   text("x: " + x + "y: " + y, x, y); 
   text("col: " + currNode.col + "row: " + currNode.row, x, y+15); 
  // text("col: " + nextNode.col + "row: " + nextNode.row, x, y+15); 
   // text("speed: " + speed, x, y  + 15);
 }
}
