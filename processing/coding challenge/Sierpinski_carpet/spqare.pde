class square{
  PVector l;
  float r;
  square(float x,float y,float r_){
    l=new PVector(x,y);
    r=r_;
  }
  void display(){
    //pushMatrix();
    rectMode(CENTER);
    rect(l.x,l.y,r,r);
   // popMatrix();
  }
  
  ArrayList<square> generate(){
    ArrayList<square> squares=new ArrayList<square>();
    for(int x=-1;x<2;x+=1){
      for(int y=-1;y<2;y+=1){
        float newR=r/3;
        if(abs(x)+abs(y)>0){
          square s1=new square(l.x+x*newR,l.y+y*newR,newR);
            squares.add(s1);
        }
        
      }
    }
    return squares;
  }
}
