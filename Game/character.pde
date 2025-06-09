class character{
  Node currNode; 
  Node nextNode; 
  Node prevNode; 
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
 
 void setCurrNode(Node node, PImage img ){
   currNode = node;
   x = node.x;
   y = node.y;
   icon = img;
 }
 
 // updates the characters x and y and node only once it's in the center of the node
void inch(){
  if (nextNode != null){
    float dx = nextNode.x - x;
    float dy = nextNode.y - y;
    float dist = sqrt(dx*dx + dy*dy);

    // If the distance is less than the speed, just move to the node.
    if (dist < speed) {
      x = nextNode.x;
      y = nextNode.y;
    }
    // Otherwise, move normally.
    else if (dist > 0){
      x += (dx/dist) * speed;
      y += (dy/dist) * speed;
    }

    if (abs(x - nextNode.x) <= 1 && abs(y - nextNode.y) <= 1){
      prevNode = currNode;
      currNode = nextNode;
      x = currNode.x;
      y = currNode.y;
    }
  }
}
 
 void printNode( Node x ){
    System.out.println( x.row+" "+x.col); 
 }
 
 void move(int dr, int dc){
   for (Node neighbor : currNode.neighbors){ // check through all the neighbors to find the right one to move to
     if (neighbor.row == currNode.row + dr && neighbor.col == currNode.col + dc){
       nextNode = neighbor; 
     }
   }
 }
 
 void display(){
   image(icon, x, y);
   fill(255); 
 }
}
