class enemy{
  int r=(int)random(4);
  PVector location;
  PVector velocity;
  PVector acceleration;
  float hp=100;
  float attackdamage=10;
  int index=0;
  enemy(){
    create();    
  }
  
  void run(){
    show();
    update();
    stroke(255);
    textSize(12);
    text("hp:"+str((int)hp),location.x-25,location.y-25);
  }
  void show(){
    fill(255,0,0);
    noStroke();
    imageMode(CENTER);
    image(HGU,location.x,location.y,30,30);
  }
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    PVector rv=PVector.random2D();
    rv.normalize();
    rv.mult(0.1);
    velocity.add(rv);
  }
  boolean isdeath(){
     if(hp<=0 || location.x<-100||location.x>width+100||location.y<-100||location.y>height+100){
       return true;     
     }
     else return false;
  }
  
  
  
  
  
  
  void create(){
    if(r==0){
      location=new PVector(-10,random(height));
      velocity=new PVector(1,0);
    }
    if(r==1){
      location=new PVector(random(width),-10);
      velocity=new PVector(0,1);
    }
    if(r==2){
      location=new PVector(width+10,random(height));
      velocity=new PVector(-1,0);
    }
    if(r==3){
      location=new PVector(random(width),height+10);
      velocity=new PVector(0,-1);
    }
    acceleration=new PVector(0,0);
  }
  
  
}
