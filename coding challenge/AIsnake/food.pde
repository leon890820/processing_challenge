class food{
  PVector location;
  food(){
    location=new PVector((int)random(row),(int)random(cul));
  }
  void run(){
    show();
    
  }
  void show(){
    fill(255,0,0);
    rect(location.x*scl,location.y*scl,scl,scl);
  }
  void eaten(){
    
    location=new PVector((int)random(row),(int)random(cul));
  }

}
