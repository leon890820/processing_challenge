class bossbullet {
  PVector location;
  PVector velocity;
  float attackdamage=10;
  bossbullet(float x,float y,float vx,float vy){
    location=new PVector(x,y); 
    velocity=new PVector(vx,vy);
  }
  void run(){
    show();
    update();
    
  }
  void show(){
    fill(0,0,255);
    noStroke();
    circle(location.x,location.y,10);
  }
  void update(){
    location.add(velocity);
  }
  boolean isdeath(){
     if( location.x<-100||location.x>width+100||location.y<-100||location.y>height+100){
       return true;     
     }
     else return false;
  }

}
