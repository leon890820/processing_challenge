class Box{
  PVector l;
  float r;
  Box(float x,float y,float z,float r_){
    l=new PVector(x,y,z);
    r=r_;
  }
  void show(){
    pushMatrix();
    translate(l.x,l.y,l.z);
    box(r);
    popMatrix();
  }
  ArrayList<Box> generate(){
    ArrayList<Box> boxes=new ArrayList<Box>();
    for(int x=-1;x<2;x+=1){
      for(int y=-1;y<2;y+=1){
        for(int z=-1;z<2;z+=1){
          float newR=r/3;
          if(abs(x)+abs(y)+abs(z)>1){
             Box b=new Box(l.x+newR*x,l.y+newR*y,l.z+newR*z,newR);
             boxes.add(b);
          }
        }
      }
    }
    return boxes;
  }
  
    
}
