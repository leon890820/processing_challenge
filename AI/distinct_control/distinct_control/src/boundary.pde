class Boundary{
  PVector start;
  PVector end;
  Boundary(float x1,float x2,float x3,float x4){
    start=new PVector(x1,x2);
    end=new PVector(x3,x4);  
  }
  void show(){
    stroke(255);
    strokeWeight(1);
    line(mapTheX(start.x),mapTheY(start.y),mapTheX(end.x),mapTheY(end.y));
    
  }
}
