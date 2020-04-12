class food{
  PVector location;
  boolean clone=false;
  ArrayList<PVector> foodl;
  float t=0;
  food(){
    foodl=new ArrayList<PVector>();
    location=new PVector((int)random(row),(int)random(cul));
    foodl.add(location);
    //location=new PVector(10,10);
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
    foodl.add(location);
  }
  void ceaten(){
    location=foodl.get((int)t);
    t+=1;
    location=new PVector((int)random(row),(int)random(cul));
    foodl.add(location);
  }

}
