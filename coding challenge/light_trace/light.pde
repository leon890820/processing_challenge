class Light{
  PVector position;
  Ray[] ray=new Ray[rayNum];
  Light(float x,float y){
    position=new PVector(x,y);
    for(int i=0;i<ray.length;i+=1){
      float a=map(i,0,ray.length,0,2*PI);
      ray[i]=new Ray(position.x,position.y,a);
    }
  }
  void show(float x,float y){
    position=new PVector(x,y);
    fill(255);    
    circle(position.x,position.y,10);
    for(Ray r:ray){
      r.position=new PVector(x,y);
      float record=100000;
      PVector mb=null;
      for(Boundary b:boundary){
        PVector pt=r.show(b);
        if(pt==null) continue;
        float d=dist(pt.x,pt.y,position.x,position.y);
        if(record>d){
          record=d;
          mb=pt.copy();
        }
      }
      if(mb==null) continue;
      stroke(255,100);
      line(mb.x,mb.y,position.x,position.y);
    }
  
  }


}
