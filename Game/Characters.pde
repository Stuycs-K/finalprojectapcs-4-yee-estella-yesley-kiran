class Characters{
  int Xloc;
  int Yloc;
  PImage Image; 
  
  Character(int startX, int startY, PImage val){
      Xloc = startX;
      Yloc = startY;
      Image = val;
  }
  
  int move(int dx, int dy){
    Xloc += dx;
    Yloc += dy;
  }
  
  int[] currLocation(){
    int[] ans = {Xloc, Yloc};
    return ans;
  }
  
  void displayChar(){
    image(Image, Xloc, Yloc);
  }
}
