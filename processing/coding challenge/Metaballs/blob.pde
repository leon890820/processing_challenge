class blob{
  PVector pos;
  float r;
  PVector vel; 
  blob(float x,float y,float r_){
    pos=new PVector(x,y);
    vel=PVector.random2D();
    vel.mult(random(2,5));
    r=r_;
    
  }
  void run(){
    show();
    update();
  }
  void show(){
    noFill();
    stroke(0);
    //strokeWeight(4);
    //circle(pos.x,pos.y,r);
  }
  void update(){   
    pos.add(vel);
    if(pos.x>width||pos.x<0){
      vel.x*=-1;
    }
    if(pos.y>height||pos.y<0){
      vel.y*=-1;
    }
  }



}
