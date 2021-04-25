class Boundary{
  PVector start;
  PVector end;
  
  Boundary(float x1,float y1,float x2,float y2){
    start=new PVector(x1,y1);
    end=new PVector(x2,y2);
  }
  void show(){
    stroke(255);
    line(start.x,start.y,end.x,end.y);
  
  }
}
