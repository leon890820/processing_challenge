class water{
  PVector location;
  PVector prelocation;
  PVector velocity;
  PVector acceleration;
  float cy;
  float precy;
  float mass;
  water(){
    location=new PVector(random(-500,width-200),random(0,height),random(800,1500));
    cy=map(location.y,0,height,height*(1-s),height);
    precy=cy;
    prelocation=location;
    velocity=new PVector(0,0,0);
    acceleration=new PVector(0.3,0,-0.8);
    mass=random(1,5);
  }
  void run(){
    show();
    drop(); 
  }
  void show(){
    float a=map(location.y,0,height,100,255);
    stroke(255,255,255,a);
    strokeWeight(1);
    line(location.x,cy-location.z,prelocation.x,precy-prelocation.z);   
  }
  
  void drop(){
    prelocation=location.copy();
    location.add(velocity);
    velocity.add(acceleration);
  }
  


}
