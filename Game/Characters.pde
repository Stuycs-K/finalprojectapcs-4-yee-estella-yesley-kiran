class Characters{
  int Xloc;
  int Yloc;
  PImage Image; 
  
  Characters(int startX, int startY, PImage img){
      Xloc = startX;
      Yloc = startY;
      Image = img;
  }
  
 void move(int dx, int dy){
    Xloc += dx * 5;
    Yloc += dy * 5;
  }
  
  int[] currLocation(){
    int[] ans = {Xloc, Yloc};
    return ans;
  }
  
  void display(){
    image(Image, Xloc, Yloc);
  }
}
